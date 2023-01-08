import Foundation

protocol PokeService {
    func execute<T: Codable>(_ request: PokeRequest, expecting type: T.Type) async -> Result<[T], Error>
}

final class PokeAPIService: PokeService, Sendable {

    // MARK: Internal

    enum PokeApiServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }

    func execute<T: Codable & Sendable>(_ request: PokeRequest, expecting type: T.Type) async -> Result<[T], Error> {
        guard let urlRequest = urlRequest(from: request) else { return .failure(PokeApiServiceError.failedToCreateRequest) }

        return await fetchPaginatedResponse(from: urlRequest, expecting: T.self)
    }

    // MARK: Private

    private func fetchSingleResult<T: Codable & Sendable>(from request: URLRequest, expecting type: T.Type) async -> Result<T, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode(T.self, from: data)

            return .success(result)
        } catch {
            return .failure(error)
        }
    }

    private func fetchPaginatedResponse<T: Codable & Sendable>(from request: URLRequest, expecting type: T.Type) async -> Result<[T], Error> {
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(PaginatedResponse<NamedPokemonResource>.self, from: data)

            return await withTaskGroup(of: Result<T, Error>.self) { group in
                for result in response.results {
                    guard let url = URL(string: result.url) else { continue }

                    group.addTask {
                        await self.fetchSingleResult(from: URLRequest(url: url), expecting: T.self)
                    }
                }

                let taskGroupResults = await group.reduce(into: []) { collection, element in
                    collection.append(element)
                }

                if taskGroupResults.allSatisfy({ $0.isSuccess }) {
                    return .success(taskGroupResults.compactMap({ try? $0.get() }))
                } else {
                    return .failure(PokeApiServiceError.failedToGetData)
                }
            }
        } catch {
            return .failure(error)
        }
    }

    private func urlRequest(from request: PokeRequest) -> URLRequest? {
        guard let requestUrl = request.url else { return nil }

        return URLRequest(url: requestUrl)
    }

    private struct PaginatedResponse<T: Codable>: Codable {
        let count: Int
        let next: String?
        let previous: String?
        let results: [T]
    }
}

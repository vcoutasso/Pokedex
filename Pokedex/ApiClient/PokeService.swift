import Foundation

protocol PokeService {
    func execute<R: PokeRequestProtocol>(_ request: R) async -> Result<PaginatedPokeAPIResponse, Error> where R.PokeEndpoint == PaginatedPokeEndpoint
    func execute<R: PokeRequestProtocol, T: Codable>(_ request: R, expecting type: T.Type) async -> Result<[T], Error> where R.PokeEndpoint == SinglePokeEndpoint
}

final class PokeAPIService: PokeService, Sendable {

    // MARK: Internal

    enum PokeApiServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }

    func execute<R: PokeRequestProtocol>(_ request: R) async -> Result<PaginatedPokeAPIResponse, Error> where R.PokeEndpoint == PaginatedPokeEndpoint {
        guard let urlRequest = urlRequest(from: request) else { return .failure(PokeApiServiceError.failedToCreateRequest) }

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let response = try JSONDecoder().decode(PaginatedPokeAPIResponse.self, from: data)

            return .success(response)
        } catch {
            return .failure(error)
        }
    }

    func execute<R: PokeRequestProtocol, T: Codable>(_ request: R, expecting type: T.Type) async -> Result<[T], Error> where R.PokeEndpoint == SinglePokeEndpoint {
        guard let urlRequest = urlRequest(from: request) else { return .failure(PokeApiServiceError.failedToCreateRequest) }

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let response = try JSONDecoder().decode([T].self, from: data)

            return .success(response)
        } catch {
            return .failure(error)
        }
    }

    // MARK: Private

    private func urlRequest(from request: any PokeRequestProtocol) -> URLRequest? {
        guard let requestUrl = request.url else { return nil }

        return URLRequest(url: requestUrl)
    }
}

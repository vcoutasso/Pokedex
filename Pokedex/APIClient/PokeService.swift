import Foundation

protocol PokeService {
    func execute<R: PokeAPIRequestProtocol>(_ request: R) async -> Result<PaginatedPokeAPIResponse, Error> where R.PokeAPIEndpoint == PaginatedPokeAPIEndpoint
    func execute<R: PokeAPIRequestProtocol, T: Codable>(_ request: R, expecting type: T.Type) async -> Result<T, Error> where R.PokeAPIEndpoint == SinglePokeAPIEndpoint
}

final class PokeAPIService: PokeService, Sendable {

    // MARK: Lifecycle

    private init() {}

    // MARK: Internal

    static let shared = PokeAPIService()

    func execute<R: PokeAPIRequestProtocol>(_ request: R) async -> Result<PaginatedPokeAPIResponse, Error> where R.PokeAPIEndpoint == PaginatedPokeAPIEndpoint {
        guard let urlRequest = urlRequest(from: request) else { return .failure(PokeApiServiceError.failedToCreateRequest) }

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let response = try JSONDecoder().decode(PaginatedPokeAPIResponse.self, from: data)

            return .success(response)
        } catch {
            return .failure(error)
        }
    }

    func execute<R: PokeAPIRequestProtocol, T: Codable>(_ request: R, expecting type: T.Type) async -> Result<T, Error> where R.PokeAPIEndpoint == SinglePokeAPIEndpoint {
        guard let urlRequest = urlRequest(from: request) else { return .failure(PokeApiServiceError.failedToCreateRequest) }

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let response = try JSONDecoder().decode(T.self, from: data)

            return .success(response)
        } catch {
            return .failure(error)
        }
    }

    enum PokeApiServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }

    // MARK: Private

    private func urlRequest(from request: any PokeAPIRequestProtocol) -> URLRequest? {
        guard let requestUrl = request.url else { return nil }

        return URLRequest(url: requestUrl)
    }
}

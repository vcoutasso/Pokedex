import Foundation

protocol PokeRequestProtocol: Sendable {
    associatedtype PokeEndpoint

    init(endpoint: PokeEndpoint, queryItems: [URLQueryItem])

    var endpoint: PokeEndpoint { get }
    var url: URL? { get }
}

/// Represents a single PokeAPI call
struct PokeRequest<Endpoint: PokeEndpointProtocol>: PokeRequestProtocol {

    // MARK: Lifecycle

    init(endpoint: Endpoint, queryItems: [URLQueryItem] = []) {
        self.endpoint = endpoint
        let path = "\(endpoint.rawValue)/"
        self.url = URLComponents(string: baseUrl + path)?.url?.appending(queryItems: queryItems)
    }

    // MARK: Internal

    let endpoint: Endpoint

    let url: URL?

    let httpMethod = "GET"

    // MARK: Private

    private let baseUrl: String = "https://pokeapi.co/api/v2/"
}

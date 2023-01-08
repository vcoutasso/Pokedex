import Foundation

protocol PokeAPIRequestProtocol: Sendable {
    associatedtype PokeAPIEndpoint

    init?(urlString: String)
    init(endpoint: PokeAPIEndpoint, queryItems: [URLQueryItem])

    var endpoint: PokeAPIEndpoint { get }
    var url: URL? { get }
}

/// Represents a single PokeAPI call
struct PokeAPIRequest<Endpoint: PokeAPIEndpointProtocol>: PokeAPIRequestProtocol {

    // MARK: Lifecycle

    init?(urlString: String) {
        guard urlString.starts(with: baseUrl),
              let urlComponents = URLComponents(string: urlString),
              let anyEndpoint: any PokeAPIEndpointProtocol = PaginatedPokeAPIEndpoint(rawValue: urlComponents.path) ?? SinglePokeAPIEndpoint(rawValue: urlComponents.path),
            let endpoint = anyEndpoint as? Endpoint
        else { return nil }

        self.endpoint = endpoint
        self.url = urlComponents.url
    }

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

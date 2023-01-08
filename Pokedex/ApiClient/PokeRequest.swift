import Foundation

/// Represents a single PokeAPI call
struct PokeRequest {

    // MARK: Lifecycle

    init(endpoint: PokeEndpoint, queryItems: [URLQueryItem] = []) {
        self.endpoint = endpoint
        let path = "\(endpoint.rawValue)/"
        self.url = URLComponents(string: baseUrl + path)?.url?.appending(queryItems: queryItems)
    }

    // MARK: Internal

    let endpoint: PokeEndpoint

    let url: URL?

    let httpMethod = "GET"

    // MARK: Private

    private let baseUrl: String = "https://pokeapi.co/api/v2/"
}

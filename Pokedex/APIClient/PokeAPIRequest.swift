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
        let path = urlString.replacingOccurrences(of: baseUrl, with: "").trimmingCharacters(in: .punctuationCharacters)
        
        guard urlString.starts(with: baseUrl),
              let endpoint = Endpoint(rawValue: path)
        else { return nil }

        let urlComponents = URLComponents(string: urlString)

        self.endpoint = endpoint
        self.queryItems = urlComponents?.queryItems ?? []
    }

    init(endpoint: Endpoint, queryItems: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.queryItems = queryItems
    }

    // MARK: Internal

    let endpoint: Endpoint
    let queryItems: [URLQueryItem]

    var url: URL? {
        URLComponents(string: baseUrl + endpoint.rawValue)?.url?.appending(queryItems: queryItems)
    }

    let httpMethod = "GET"

    // MARK: Private

    private let baseUrl: String = "https://pokeapi.co/api/v2/"
}

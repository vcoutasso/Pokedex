import Foundation

protocol PokeAPIEndpointProtocol: RawRepresentable, Sendable where RawValue == String {

}

/// Represents an endpoint that produces a paginated response for multiple data entries
enum PaginatedPokeAPIEndpoint: String, CaseIterable, PokeAPIEndpointProtocol {
    /// Endpoint to get for multiple pokemons
    case pokemon
}

/// Represents an endpoint that produces a response for a single data entry
enum SinglePokeAPIEndpoint: PokeAPIEndpointProtocol {
    init?(rawValue: String) {
        let pathComponents = rawValue.split(separator: "/")
        guard pathComponents.count == 2, // We expect two components: the first should be a valid paginated endpoint, and the second a valid integer id
              let path = pathComponents.first,
              let idString = pathComponents.last,
              let paginatedEndpoint = PaginatedPokeAPIEndpoint.allCases.first(where: ({ $0.rawValue == path })),
              let id = Int(idString)
        else {
            return nil
        }

        switch paginatedEndpoint {
            case .pokemon:
                self = .pokemon(id)
        }
    }

    /// Endpoint to get  a single pokemon info
    case pokemon(Int)

    var rawValue: String {
        let path = String(describing: self).replacingOccurrences(of: "[^A-Za-z]+", with: "", options: [.regularExpression])
        let id = String(describing: self).replacingOccurrences(of: "[^0-9]+", with: "", options: [.regularExpression])

        return "\(path)/\(id)"
    }
}

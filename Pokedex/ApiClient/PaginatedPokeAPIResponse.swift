import Foundation

struct PaginatedPokeAPIResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [NamedPokeAPIResource]
}

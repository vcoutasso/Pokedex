import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    /// In decimeters
    let height: Int
    /// In hectograms
    let weight: Int
    let abilities: [PokemonAbility]
    let stats: [PokemonStat]
    let types: [PokemonType]
}

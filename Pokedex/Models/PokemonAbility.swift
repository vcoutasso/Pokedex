import Foundation

struct PokemonAbility: Codable {
    let ability: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let resource = try container.decode(NamedPokemonResource.self, forKey: .ability)
        self.ability = resource.name
    }
}

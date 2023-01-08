import Foundation

struct PokemonAbility: Codable {
    let ability: String

    init(ability: String) {
        self.ability = ability
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let resource = try container.decode(NamedPokeAPIResource.self, forKey: .ability)
        self.ability = resource.name
    }
}

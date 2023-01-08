import Foundation

struct PokemonType: Codable {
    let slot: Int
    let type: PokemonTypes

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let typeRawValue = try container.decode(NamedPokemonResource.self, forKey: .type).name
        guard let type = PokemonTypes(rawValue: typeRawValue) else {
            throw PokemonTypeError.failedToDecodePokemonType
        }
        self.slot = try container.decode(Int.self, forKey: .slot)
        self.type = type
    }

    enum PokemonTypeError: Error {
        case failedToDecodePokemonType
    }
}

// MARK: - PokemonTypes

enum PokemonTypes: String, Codable {
    case rock
    case ghost
    case steel
    case water
    case grass
    case psychic
    case ice
    case dark
    case fairy
    case normal
    case fighting
    case flying
    case poison
    case ground
    case bug
    case fire
    case electric
    case dragon
    case shadow
    case unknown
}

extension PokemonTypes: CustomStringConvertible {
    var description: String {
        self.rawValue.capitalized
    }
}

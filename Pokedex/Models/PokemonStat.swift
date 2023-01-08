import Foundation

struct PokemonStat: Codable {
    let stat: PokemonStats
    let value: Int

    init(stat: PokemonStats, value: Int) {
        self.stat = stat
        self.value = value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let statRawValue = try container.decode(NamedPokeAPIResource.self, forKey: .stat).name
        guard let stat = PokemonStats(rawValue: statRawValue) else {
            throw PokemonStatError.failedToDecodePokemonStat
        }
        self.value = try container.decode(Int.self, forKey: .value)
        self.stat = stat
    }

    enum PokemonStatError: Error {
        case failedToDecodePokemonStat
    }

    private enum CodingKeys: String, CodingKey {
        case stat = "stat"
        case value = "base_stat"
    }
}

// MARK: - PokemonStats

enum PokemonStats: String, Codable {
    case hp
    case attack
    case defense
    case specialAttack = "special-attack"
    case specialDefense = "special-defense"
    case speed
    case accuracy
    case evasion
}

extension PokemonStats: CustomStringConvertible {
    var description: String {
        switch self {
            case .hp:
                return "HP"
            case .attack:
                return "ATK"
            case .defense:
                return "DEF"
            case .specialAttack:
                return "SATK"
            case .specialDefense:
                return "SDEF"
            case .speed:
                return "SPD"
            case .accuracy:
                return "ACC"
            case .evasion:
                return "EVA"
        }
    }
}

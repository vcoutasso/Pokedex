import Foundation

final class PreviewPokeAPIService: PokeService, Sendable {
    func execute<R>(_ request: R) async -> Result<PaginatedPokeAPIResponse, Error> where R : PokeAPIRequestProtocol, R.PokeAPIEndpoint == PaginatedPokeAPIEndpoint {
        return .failure(PreviewPokemonError.unsupportedType)
    }

    func execute<R, T>(_ request: R, expecting type: T.Type) async -> Result<T, Error> where R : PokeAPIRequestProtocol, T : Decodable, T : Encodable, R.PokeAPIEndpoint == SinglePokeAPIEndpoint {
        guard let pokemon = PreviewPokeAPIService.previewPokemon as? T else {
            return .failure(PreviewPokemonError.unsupportedType)
        }

        return .success(pokemon)
    }

    enum PreviewPokemonError: Error {
        case unsupportedType
    }

    private static let previewPokemon: Pokemon = .init(
        id: 999,
        name: "Pokémon Name",
        height: 99,
        weight: 99,
        abilities: [
            .init(ability: "Ability 1"),
            .init(ability: "Ability 2"),
        ],
        stats: [
            .init(stat: .hp, value: 45),
            .init(stat: .attack, value: 49),
            .init(stat: .defense, value: 49),
            .init(stat: .specialAttack, value: 65),
            .init(stat: .specialDefense, value: 65),
            .init(stat: .speed, value: 45),
            .init(stat: .accuracy, value: 42),
            .init(stat: .evasion, value: 42),
        ],
        types: [
            .init(slot: 1, type: .unknown),
            .init(slot: 2, type: .unknown),
        ])
}

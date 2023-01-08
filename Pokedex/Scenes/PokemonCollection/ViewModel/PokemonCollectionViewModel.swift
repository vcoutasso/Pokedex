import Foundation

@MainActor
protocol PokemonCollectionViewModelProtocol: ObservableObject {
    var pokemonViewModels: [any PokemonCardViewModelProtocol] { get }

    func fetchPokemons() async
    func fetchMorePokemons() async
}

final class PokemonCollectionViewModel: PokemonCollectionViewModelProtocol {
    // MARK: Lifecycle

    init(pokeService: PokeService) {
        self.pokeService = pokeService
    }

    // MARK: Internal

    @Published private(set) var pokemonViewModels = [any PokemonCardViewModelProtocol]()

    func fetchPokemons() async {
        switch await pokeService.execute(PokeAPIRequest(endpoint: PaginatedPokeAPIEndpoint.pokemon)) {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
        }
    }

    func fetchMorePokemons() async {

    }

    // MARK: Private

    private let pokeService: PokeService
}

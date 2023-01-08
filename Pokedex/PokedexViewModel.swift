import Foundation

protocol PokedexViewModelProtocol: AnyObject, ObservableObject {
    func fetchPokemons() async
    func fetchMorePokemons() async
}

@MainActor
final class PokedexViewModel: PokedexViewModelProtocol {
    // MARK: Lifecycle

    init(pokeService: PokeService) {
        self.pokeService = pokeService
    }

    // MARK: Internal

    @Published private(set) var pokemons = [Pokemon]()

    func fetchPokemons() async {
        switch await pokeService.execute(PokeRequest(endpoint: PaginatedPokeEndpoint.pokemon, queryItems: [])) {
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

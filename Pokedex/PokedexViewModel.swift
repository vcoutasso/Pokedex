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
        switch await pokeService.execute(.init(endpoint: .pokemon), expecting: Pokemon.self) {
            case .success(let response):
                self.pokemons = response.sorted(by: { $0.id < $1.id })
            case .failure(let error):
                print(error)
        }
    }

    func fetchMorePokemons() async {

    }

    // MARK: Private

    private let pokeService: PokeService
}

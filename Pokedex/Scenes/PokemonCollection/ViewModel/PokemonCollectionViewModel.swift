import Foundation

@MainActor
protocol PokemonCollectionViewModelProtocol: ObservableObject {
    var pokemonViewModels: [any PokemonCardViewModelProtocol] { get }

    func fetchPokemons() async
    func fetchMorePokemons() async
}

final class PokemonCollectionViewModel: PokemonCollectionViewModelProtocol {
    // MARK: Lifecycle

    init(pokeService: PokeService = PokeAPIService.shared) {
        self.pokeService = pokeService
    }

    // MARK: Internal

    @Published private(set) var pokemonViewModels = [any PokemonCardViewModelProtocol]()

    func fetchPokemons() async {
        guard !isFetching else { return }

        isFetching = true

        switch await pokeService.execute(PokeAPIRequest(endpoint: PaginatedPokeAPIEndpoint.pokemon)) {
            case .success(let response):
                nextPageURLString = response.next
                for result in response.results {
                    guard let request = PokeAPIRequest<SinglePokeAPIEndpoint>(urlString: result.url) else {
                        print("Failed to create request for \(result)")
                        continue
                    }

                    pokemonViewModels.append(PokemonCardViewModel(request: request))
                }
            case .failure(let error):
                print(error)
        }

        isFetching = false
    }


    func fetchMorePokemons() async {
        guard nextPageURLString != nil else { return }

        await fetchPokemons()
    }

    // MARK: Private

    private let pokeService: PokeService

    private var nextPageURLString: String?
    private var isFetching: Bool = false
}

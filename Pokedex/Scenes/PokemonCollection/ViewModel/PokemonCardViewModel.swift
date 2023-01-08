import Combine

@MainActor
protocol PokemonCardViewModelProtocol: ObservableObject {
    associatedtype Request: PokeAPIRequestProtocol

    var request: Request { get }
    var pokemon: Pokemon? { get }

    func fetchData() async
}

final class PokemonCardViewModel<Request: PokeAPIRequestProtocol>: PokemonCardViewModelProtocol where Request.PokeAPIEndpoint == SinglePokeAPIEndpoint {

    // MARK: Lifecycle

    init(request: Request, service: PokeService = PokeAPIService.shared) {
        self.request = request
        self.service = service
    }

    // MARK: Internal

    @Published private(set) var pokemon: Pokemon? = nil

    private(set) var request: Request

    func fetchData() async {
        switch await service.execute(request, expecting: Pokemon.self) {
            case .success(let pokemon):
                self.pokemon = pokemon
            case .failure(let error):
                print("Failed to fulfill request \(request) with error \(error)")
        }
    }

    // MARK: Private

    private let service: PokeService
}

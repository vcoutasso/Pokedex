import Combine

@MainActor
protocol PokemonCardViewModelProtocol: ObservableObject {
    associatedtype Request: PokeAPIRequestProtocol

    var request: Request { get }
}

final class PokemonCardViewModel<Request: PokeAPIRequestProtocol>: PokemonCardViewModelProtocol where Request.PokeAPIEndpoint == SinglePokeAPIEndpoint {
    private(set) var request: Request

    init(request: Request) {
        self.request = request
    }
}

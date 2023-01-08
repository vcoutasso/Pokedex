import SwiftUI

struct PokemonCardView<ViewModel: PokemonCardViewModelProtocol>: View {
    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        Text("oi")
    }
}

#if DEBUG
struct PokemonCardView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCardView(viewModel: PokemonCardViewModel(request: PokeAPIRequest(endpoint: SinglePokeAPIEndpoint.pokemon(1))))
    }
}
#endif

import SwiftUI

struct PokemonCardView<ViewModel: PokemonCardViewModelProtocol>: View {
    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        Group {
            Text(viewModel.pokemon?.name ?? "")
        }
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
        }
    }
}

struct PokemonCardView_Previews: PreviewProvider {
    static var previews: some View {
        let request = PokeAPIRequest(endpoint: SinglePokeAPIEndpoint.pokemon(1))
        let service = PreviewPokeAPIService()
        let viewModel = PokemonCardViewModel(request: request, service: service)
        PokemonCardView(viewModel: viewModel)
    }
}

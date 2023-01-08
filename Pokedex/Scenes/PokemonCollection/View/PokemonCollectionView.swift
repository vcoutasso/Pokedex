import SwiftUI

struct PokemonCollectionView<ViewModel: PokemonCollectionViewModelProtocol>: View {
    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.fetchPokemons()
            }
        }
    }
}

struct PokemonCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCollectionView(viewModel: PokemonCollectionViewModel())
    }
}

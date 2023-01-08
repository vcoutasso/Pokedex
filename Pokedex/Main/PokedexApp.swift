import SwiftUI

@main
struct PokedexApp: App {
    var body: some Scene {
        WindowGroup {
            PokemonCollectionView(viewModel: PokemonCollectionViewModel(pokeService: PokeAPIService.shared))
        }
    }
}

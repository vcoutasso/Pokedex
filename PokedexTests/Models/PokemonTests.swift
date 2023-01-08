import XCTest

@testable import Pokedex

final class PokemonTests: XCTestCase {
    private let testBundle: Bundle = .init(for: PokemonTests.self)

    func testPokemonShouldDecodeFromJSON() throws {
        // Given
        let url = try XCTUnwrap(testBundle.url(forResource: "Charmander", withExtension: "json"))
        let data = try XCTUnwrap(Data(contentsOf: url))

        // When
        let decodedData = try? JSONDecoder().decode(Pokemon.self, from: data)

        // Then
        XCTAssertNotNil(decodedData)
    }
}

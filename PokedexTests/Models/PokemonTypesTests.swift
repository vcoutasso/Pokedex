import XCTest

@testable import Pokedex

final class PokemonTypesTests: XCTestCase {
    private let testBundle: Bundle = .init(for: PokemonTypesTests.self)

    func testAllPokemonTypesShouldDecodeFromJSON() throws {
        // Given
        let url = try XCTUnwrap(testBundle.url(forResource: "PokemonTypes", withExtension: "json"))
        let data = try XCTUnwrap(Data(contentsOf: url))

        // When
        let decodedData = try? JSONDecoder().decode(AllPokemonTypes.self, from: data)

        // Then
        XCTAssertNotNil(decodedData)
    }
}

private struct AllPokemonTypes: Codable {
    let types: [PokemonTypes]
}


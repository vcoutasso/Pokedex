import XCTest
@testable import Pokedex

final class PokemonModelTests: XCTestCase {
    private let testBundle: Bundle = .init(for: PokemonModelTests.self)

    func testPokemonShouldDecodeFromJSON() throws {
        // Given
        let url = try XCTUnwrap(testBundle.url(forResource: "Charmander", withExtension: "json"))
        let data = try XCTUnwrap(Data(contentsOf: url))

        // When
        let decodedData = try? JSONDecoder().decode(Pokemon.self, from: data)

        // Then
        XCTAssertNotNil(decodedData)
    }

    func testAllPokemonTypesShouldDecodeFromJSON() throws {
        // Given
        let url = try XCTUnwrap(testBundle.url(forResource: "PokemonTypes", withExtension: "json"))
        let data = try XCTUnwrap(Data(contentsOf: url))

        // When
        let decodedData = try? JSONDecoder().decode(AllPokemonTypes.self, from: data)

        // Then
        XCTAssertNotNil(decodedData)
    }

    func testAllPokemonStatsShouldDecodeFromJSON() throws {
        // Given
        let url = try XCTUnwrap(testBundle.url(forResource: "PokemonStats", withExtension: "json"))
        let data = try XCTUnwrap(Data(contentsOf: url))

        // When
        let decodedData = try? JSONDecoder().decode(AllPokemonStats.self, from: data)

        // Then
        XCTAssertNotNil(decodedData)
    }
}

private struct AllPokemonTypes: Codable {
    let types: [PokemonTypes]
}

private struct AllPokemonStats: Codable {
    let stats: [PokemonStats]
}

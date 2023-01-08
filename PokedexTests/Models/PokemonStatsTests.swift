import XCTest

@testable import Pokedex

final class PokemonStatsTests: XCTestCase {
    private let testBundle: Bundle = .init(for: PokemonStatsTests.self)

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

private struct AllPokemonStats: Codable {
    let stats: [PokemonStats]
}

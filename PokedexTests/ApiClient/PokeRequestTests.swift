import XCTest

@testable import Pokedex

final class PokeRequestTests: XCTestCase {
    func testPaginatedPokemonEndpointRequestShouldProduceValidURL() {
        // Given
        let request = PokeRequest(endpoint: PaginatedPokeEndpoint.pokemon)

        // When
        let url = request.url

        // Then
        XCTAssertNotNil(url)
    }

    func testSinglePokemonEndpointRequestShouldProduceValidURL() {
        // Given
        let request = PokeRequest(endpoint: SinglePokeEndpoint.pokemon(1))

        // When
        let url = request.url

        // Then
        XCTAssertNotNil(url)
    }
}

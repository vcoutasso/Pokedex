import XCTest

@testable import Pokedex

final class PokeRequestTests: XCTestCase {
    func testPokemonEndpointRequestShouldProduceValidURL() {
        // Given
        let request = PokeRequest(endpoint: .pokemon)

        // When
        let url = request.url

        // Then
        XCTAssertNotNil(url)
    }
}

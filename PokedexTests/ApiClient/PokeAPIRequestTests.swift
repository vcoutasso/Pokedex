import XCTest

@testable import Pokedex

final class PokeAPIRequestTests: XCTestCase {
    func testPaginatedPokeAPIEndpointRequestShouldProduceValidURL() {
        // Given
        let request = PokeAPIRequest(endpoint: PaginatedPokeAPIEndpoint.pokemon)

        // When
        let url = request.url

        // Then
        XCTAssertNotNil(url)
    }

    func testSinglePokeAPIEndpointRequestShouldProduceValidURL() {
        // Given
        let request = PokeAPIRequest(endpoint: SinglePokeAPIEndpoint.pokemon(1))

        // When
        let url = request.url

        // Then
        XCTAssertNotNil(url)
    }
}

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

    func testPaginatedPokeAPIEndpointRequestShouldBeConstructedFromValidURL() {
        // Given
        let urlString = "https://pokeapi.co/api/v2/pokemon"

        // When
        let request = PokeAPIRequest<PaginatedPokeAPIEndpoint>(urlString: urlString)

        // Then
        XCTAssertNotNil(request)
    }

    func testSinglePokeAPIEndpointRequestShouldProduceValidURL() {
        // Given
        let request = PokeAPIRequest(endpoint: SinglePokeAPIEndpoint.pokemon(1))

        // When
        let url = request.url

        // Then
        XCTAssertNotNil(url)
    }

    func testSinglePokeAPIEndpointRequestShouldBeConstructedFromValidURL() {
        // Given
        let urlString = "https://pokeapi.co/api/v2/pokemon/2/"

        // When
        let request = PokeAPIRequest<SinglePokeAPIEndpoint>(urlString: urlString)

        // Then
        XCTAssertNotNil(request)
    }
}

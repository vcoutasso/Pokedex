import XCTest

@testable import Pokedex

final class PokeEndpointTests: XCTestCase {
    func testPaginatedPokemonEndpointShouldBeConstructedFromValidEndpoint() {
        // Given
        let endpointString = "pokemon"

        // When
        let endpoint = PaginatedPokeEndpoint(rawValue: endpointString)

        // Then
        XCTAssertNotNil(endpoint)
    }

    func testPaginatedPokemonEndpointShouldNotBeConstructedFromInvalidEndpoint() {
        // Given
        let endpointString = "totally_invalid_endpoint"

        // When
        let endpoint = PaginatedPokeEndpoint(rawValue: endpointString)

        // Then
        XCTAssertNil(endpoint)
    }

    func testSinglePokemonEndpointShouldBeConstructedFromValidURL() {
        // Given
        let endpointString = "pokemon/1"

        // When
        let endpoint = SinglePokeEndpoint(rawValue: endpointString)

        // Then
        XCTAssertNotNil(endpoint)
    }

    func testSinglePokemonEndpointShouldNotBeConstructedFromInvalidEndpoint() {
        // Given
        let endpointString = "totally_invalid_identifier"

        // When
        let endpoint = SinglePokeEndpoint(rawValue: endpointString)

        // Then
        XCTAssertNil(endpoint)
    }

    func testPaginatedPokemonEndpointShouldHaveSingleEndpointCounterpart() {
        // Given
        let allPaginatedEndpoints = PaginatedPokeEndpoint.allCases
        let stubID: Int = 1

        // When
        let singleEndpointCounterpart = allPaginatedEndpoints.map {
            SinglePokeEndpoint(rawValue: "\($0.rawValue)/\(stubID)")
        }

        // Then
        XCTAssertTrue(singleEndpointCounterpart.allSatisfy({ $0 != nil }))
    }
}

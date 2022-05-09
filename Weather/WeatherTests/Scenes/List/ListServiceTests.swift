@testable import Weather
import XCTest

final class ListServiceTests: XCTestCase {
    private lazy var sut = ListService()
    
    func testFetchCities_ShouldReturnTheRightNumberOfCities() {
        let cities = sut.fetchCities()
        
        XCTAssertEqual(cities.count, 8)
    }
}

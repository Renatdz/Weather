@testable import Weather
import XCTest

private final class ListPresenterSpy: ListPresenting {
    var viewController: ListDisplaying?

    private(set) var callPresentCitiesCount = 0
    private(set) var cities: [City]?

    private(set) var callSelectCityCount = 0
    private(set) var city: City?
    
    func present(cities: [City]) {
        callPresentCitiesCount += 1
        self.cities = cities
    }
    
    func select(city: City) {
        callSelectCityCount += 1
        self.city = city
    }
}

private final class ListServiceMock: ListServicing {
    var cities: [City] = []

    func fetchCities() -> [City] {
        return cities
    }
}

final class ListInteractorTests: XCTestCase {
    private let presenterSpy = ListPresenterSpy()
    private let serviceMock = ListServiceMock()
    private lazy var sut: ListInteracting = ListInteractor(
        service: serviceMock,
        presenter: presenterSpy
    )
    
    func testFetchCities_ShouldCallPresenterWithTheRightValues() {
        let cities = [
            City(id: 4118, name: "Toronto"),
            City(id: 2487956, name: "San Francisco")
        ]
        serviceMock.cities = cities
        
        sut.fetchCities()
        
        XCTAssertEqual(presenterSpy.callPresentCitiesCount, 1)
        XCTAssertEqual(presenterSpy.cities, cities)
    }
    
    func testSelectCity_ShouldCallPresenterWithTheRightValue() {
        let cities = [
            City(id: 4118, name: "Toronto"),
            City(id: 2487956, name: "San Francisco")
        ]
        serviceMock.cities = cities
        
        sut.fetchCities()
        sut.selectCity(at: 0)
        
        XCTAssertEqual(presenterSpy.callSelectCityCount, 1)
        XCTAssertEqual(presenterSpy.city, cities[0])
    }
}

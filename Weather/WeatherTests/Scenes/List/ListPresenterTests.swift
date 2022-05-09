@testable import Weather
import XCTest

private final class ListDisplayingSpy: ListDisplaying {
    private(set) var callDisplayViewModelsCount = 0
    private(set) var viewModels: [ListViewModeling]?
    
    func display(viewModels: [ListViewModeling]) {
        callDisplayViewModelsCount += 1
        self.viewModels = viewModels
    }
}

private final class ListCoordinatorSpy: ListCoordinating {
    var viewController: UIViewController?

    private(set) var callPerformCount = 0
    private(set) var action: ListAction?

    func perform(action: ListAction) {
        callPerformCount += 1
        self.action = action
    }
}

final class RegisterKeyTermsPresenterTests: XCTestCase {
    private let viewControllerSpy = ListDisplayingSpy()
    private let coordinatorSpy = ListCoordinatorSpy()
    private lazy var sut: ListPresenting = {
        let sut = ListPresenter(coordinator: coordinatorSpy)
        sut.viewController = viewControllerSpy
        return sut
    }()

    func testPresentViewModels_ShouldFormatViewModelsAndPresentToViewController() {
        let cities = [
            City(id: 4118, name: "Toronto"),
            City(id: 2487956, name: "San Francisco")
        ]
        sut.present(cities: cities)
        
        XCTAssertEqual(viewControllerSpy.callDisplayViewModelsCount, 1)
        XCTAssertEqual(viewControllerSpy.viewModels?.count, cities.count)
    }
    
    func testSelectCity_ShouldCallCoordinatorWithTheRightValue() {
        let city = City(id: 4118, name: "Toronto")
        sut.select(city: city)
        
        XCTAssertEqual(coordinatorSpy.callPerformCount, 1)
        XCTAssertEqual(coordinatorSpy.action, .detail(city))
    }
}

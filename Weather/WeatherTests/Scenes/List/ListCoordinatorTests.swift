@testable import Weather
import XCTest

final class ListCoordinatorTests: XCTestCase {
    private let viewControllerSpy = ViewControllerSpy()
    private lazy var navControllerSpy = NavigationControllerSpy(rootViewController: viewControllerSpy)
    private lazy var sut: ListCoordinating = {
        let coordinator = ListCoordinator()
        coordinator.viewController = navControllerSpy.topViewController
        return coordinator
    }()

    func testPerform_WhenActionDetail_ShouldOpenDetailScene() {
        let city = City(id: 4118, name: "Toronto")
        sut.perform(action: .detail(city))

        XCTAssertTrue(navControllerSpy.pushedViewController is DetailViewController)
    }
}

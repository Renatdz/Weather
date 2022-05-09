@testable import Weather
import XCTest

private final class DetailDisplayingSpy: DetailDisplaying {
    private(set) var callDisplayLoadingStateCount = 0
    
    private(set) var callDisplaySuccessStateCount = 0
    private(set) var successViewModel: DetailViewModeling?
    
    private(set) var callDisplayErrorStateCount = 0
    private(set) var errorViewModel: ErrorViewModeling?
    
    private(set) var callDisplayEmptyStateCount = 0
    
    func displayLoadingState() {
        callDisplayLoadingStateCount += 1
    }
    
    func displaySuccessState(with viewModel: DetailViewModeling) {
        callDisplaySuccessStateCount += 1
        successViewModel = viewModel
    }
    
    func displayErrorState(with viewModel: ErrorViewModeling) {
        callDisplayErrorStateCount += 1
        errorViewModel = viewModel
    }
    
    func displayEmptyState() {
        callDisplayEmptyStateCount += 1
    }
}

final class DetailPresenterTests: XCTestCase {
    private let viewControllerSpy = DetailDisplayingSpy()
    private lazy var sut: DetailPresenting = {
        let sut = DetailPresenter()
        sut.viewController = viewControllerSpy
        return sut
    }()
    
    func testPresentLoadingState_ShouldCallViewControllerWithTheRightValue() {
        sut.presentLoadingState()
        
        XCTAssertEqual(viewControllerSpy.callDisplayLoadingStateCount, 1)
    }
    
    func testPresentSuccessState_WhenWeatherIsNotEmpty_ShouldCallViewControllerWithTheRightValue() {
        let cityName = "Toronto"
        let weather = WeatherMock.default
        sut.presentSuccessState(withCityName: cityName, weather: weather)
        
        XCTAssertEqual(viewControllerSpy.callDisplaySuccessStateCount, 1)
        XCTAssertEqual(viewControllerSpy.successViewModel?.cityName, cityName)
    }
    
    func testPresentSuccessState_WhenWeatherIsEmpty_ShouldCallViewControllerWithTheRightValue() {
        let cityName = "Toronto"
        let weather = WeatherMock.empty
        sut.presentSuccessState(withCityName: cityName, weather: weather)
        
        XCTAssertEqual(viewControllerSpy.callDisplaySuccessStateCount, 0)
        XCTAssertEqual(viewControllerSpy.callDisplayEmptyStateCount, 1)
        XCTAssertNil(viewControllerSpy.successViewModel)
    }
    
    func testPresenterErrorState_ShouldCallViewControllerWithTheRightValue() {
        let message = NSLocalizedString("error.message.internalServer", comment: "")
        sut.presentErrorState(withMessage: message)
        
        XCTAssertEqual(viewControllerSpy.callDisplayErrorStateCount, 1)
        XCTAssertEqual(viewControllerSpy.errorViewModel?.message, message)
    }
    
    func testPresentEmptyState_ShouldCallViewControllerWithTheRightValue() {
        sut.presentEmptyState()
        
        XCTAssertEqual(viewControllerSpy.callDisplayEmptyStateCount, 1)
    }
}

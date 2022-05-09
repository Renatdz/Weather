@testable import Weather
import XCTest

private final class DetailPresenterSpy: DetailPresenting {
    var viewController: DetailDisplaying?

    private(set) var callPresentLoadingStateCount = 0
    
    private(set) var callPresentSuccessStateCount = 0
    private(set) var successStateInfo: (cityName: String, weather: Weather)?
    
    private(set) var callPresentErrorStateCount = 0
    private(set) var message: String?

    private(set) var callPresentEmptyStateCount = 0
    
    func presentLoadingState() {
        callPresentLoadingStateCount += 1
    }
    
    func presentSuccessState(withCityName cityName: String, weather: Weather) {
        callPresentSuccessStateCount += 1
        successStateInfo = (cityName: cityName, weather: weather)
    }
    
    func presentErrorState(withMessage message: String) {
        callPresentErrorStateCount += 1
        self.message = message
    }
    
    func presentEmptyState() {
        callPresentEmptyStateCount += 1
    }
}

private final class DetailServiceMock: DetailServicing {
    var expectedResult: Result<Weather, APIError> = .failure(APIError.internalServer)
    
    func fetchWeather(id: Int, completion: @escaping (Result<Weather, APIError>) -> Void) {
        completion(expectedResult)
    }
}

final class DetailInteractorTests: XCTestCase {
    private let presenterSpy = DetailPresenterSpy()
    private let serviceMock = DetailServiceMock()
    private let city = City(id: 4118, name: "Toronto")
    private lazy var sut: DetailInteracting = DetailInteractor(
        service: serviceMock,
        presenter: presenterSpy,
        city: city
    )
    
    func testFetchWeather_WhenServiceReturnsSuccess_ShouldCallPresenterWithTheRightValues() {
        let weather = WeatherMock.default
        serviceMock.expectedResult = .success(weather)
        
        sut.fetchWeather()
        
        XCTAssertEqual(presenterSpy.callPresentLoadingStateCount, 1)
        XCTAssertEqual(presenterSpy.callPresentSuccessStateCount, 1)
        XCTAssertEqual(presenterSpy.successStateInfo?.cityName, city.name)
        XCTAssertEqual(presenterSpy.successStateInfo?.weather.consolidated.count, weather.consolidated.count)
    }
    
    func testFetchWeather_WhenServiceReturnsEmpty_ShouldCallPresenterWithTheRightValues() {
        let weather = WeatherMock.empty
        serviceMock.expectedResult = .success(weather)
        
        sut.fetchWeather()
        
        XCTAssertEqual(presenterSpy.callPresentLoadingStateCount, 1)
        XCTAssertEqual(presenterSpy.callPresentSuccessStateCount, 0)
        XCTAssertEqual(presenterSpy.callPresentEmptyStateCount, 1)
        XCTAssertNil(presenterSpy.successStateInfo)
    }
    
    func testFetchWeather_WhenServiceReturnsError_ShouldCallPresenterWithTheRightValues() {
        sut.fetchWeather()
        
        XCTAssertEqual(presenterSpy.callPresentLoadingStateCount, 1)
        XCTAssertEqual(presenterSpy.callPresentSuccessStateCount, 0)
        XCTAssertEqual(presenterSpy.callPresentErrorStateCount, 1)
        XCTAssertNil(presenterSpy.successStateInfo)
        let message = NSLocalizedString("error.message.internalServer", comment: "")
        XCTAssertEqual(presenterSpy.message, message)
    }
}

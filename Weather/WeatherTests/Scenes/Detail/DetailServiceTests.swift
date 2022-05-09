@testable import Weather
import XCTest

private final class RequestManagerMock: Requestable {
    var expectedResult: Result<Data?, APIError>?
    
    func request<D>(with endpoint: Endpoint, completion: @escaping (Result<D, APIError>) -> Void) where D : Decodable {
        guard let expectedResult = expectedResult else {
            XCTFail("ExpectedResult must have a value")
            return
        }
        
        do {
            switch expectedResult {
            case .success(let data):
                guard let jsonData = data else {
                    return completion(.failure(.internalServer))
                }
                
                let decoded = try JSONDecoder().decode(D.self, from: jsonData)
                completion(.success(decoded))
                
            case .failure(let error):
                completion(.failure(error))
            }
        } catch {
            completion(.failure(.other(error: error)))
        }
    }
}

final class DetailServiceTests: XCTestCase {
    private let requestManagerMock = RequestManagerMock()
    private lazy var sut: DetailServicing = DetailService(requestManager: requestManagerMock)
    
    private var citiesMock: Data? = {
        """
        {
            "consolidated_weather": [
                {
                  "weather_state_name": "Light Cloud",
                  "min_temp": 6.265000000000001,
                  "max_temp": 13.350000000000001,
                  "the_temp": 14.335,
                }
            ]
        }
        """.data(using: .utf8)
    }()
    
    private var citiesEmptyMock: Data? = {
        """
        {
            "consolidated_weather": []
        }
        """.data(using: .utf8)
    }()
    
    func testFetchCities_WhenRequestReturnSuccess_ShouldReturnAtLeastOneCity() {
        let fetchCitiesExpectation = expectation(description: "fetchCities success")
        requestManagerMock.expectedResult = .success(citiesMock)
        
        sut.fetchWeather(id: 4118) { result in
            fetchCitiesExpectation.fulfill()
            
            guard case .success(let cities) = result else {
                XCTFail("mustn't return failure")
                return
            }
            
            XCTAssertGreaterThan(cities.consolidated.count, 0)
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchCities_WhenRequestReturnSuccess_ShouldReturnEmpty() {
        let fetchCitiesExpectation = expectation(description: "fetchCities success empty")
        requestManagerMock.expectedResult = .success(citiesEmptyMock)
        
        sut.fetchWeather(id: 4118) { result in
            fetchCitiesExpectation.fulfill()
            
            guard case .success(let cities) = result else {
                XCTFail("mustn't return failure")
                return
            }
            
            XCTAssertEqual(cities.consolidated.count, 0)
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchCities_WhenRequestReturnFailureWithDataNil_ShouldReturnAInternalServerFailure() {
        let fetchCitiesExpectation = expectation(description: "fetchCities success with data nil")
        requestManagerMock.expectedResult = .success(nil)

        sut.fetchWeather(id: 4118) { result in
            fetchCitiesExpectation.fulfill()
            
            guard case .failure(let error) = result else {
                XCTFail("mustn't return success")
                return
            }
            
            XCTAssertEqual(error, .internalServer)
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchCities_WhenRequestReturnFailureWithDataIsWrong_ShouldReturnAnOtherFailure() {
        let fakeCity: Data? = {
            """
                [
                    {
                        "id": "1",
                        "nameS": "Odin",
                        "photoURLL": "https://api.adorable.io/avatars/285/a1.png"
                    }
                ]
            """.data(using: .utf8)
        }()
        
        let fetchCitiesExpectation = expectation(description: "fetchCities success with data nil")
        requestManagerMock.expectedResult = .success(fakeCity)

        sut.fetchWeather(id: 4188) { result in
            fetchCitiesExpectation.fulfill()
            
            guard case .failure(let error) = result else {
                XCTFail("mustn't return success")
                return
            }
            
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchCities_WhenRequestReturnFailureWithMalformedUrl_ShouldReturnAMalformedUrlFailure() {
        let fetchCitiesExpectation = expectation(description: "fetchCities failure with malformedURL")
        requestManagerMock.expectedResult = .failure(.malformedUrl)

        sut.fetchWeather(id: 4188) { result in
            fetchCitiesExpectation.fulfill()
            
            guard case .failure(let error) = result else {
                XCTFail("mustn't return success")
                return
            }
            
            XCTAssertEqual(error, .malformedUrl)
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

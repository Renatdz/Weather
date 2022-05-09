@testable import Weather

enum WeatherMock {
    static let `default` = Weather(
        consolidated: [
            WeatherDetail(
                stateName: "Light Cloud",
                minTemp: 5,
                maxTemp: 14,
                temp: 12
            ),
            WeatherDetail(
                stateName: "Heavy Cloud",
                minTemp: 8,
                maxTemp: 20,
                temp: 18
            )
        ]
    )
    
    static let empty = Weather(consolidated: [])
}

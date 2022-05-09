import Foundation

struct Weather: Decodable {
    enum CodingKeys: String, CodingKey {
        case consolidated = "consolidated_weather"
    }
    
    let consolidated: [WeatherDetail]
}

struct WeatherDetail: Decodable {
    enum CodingKeys: String, CodingKey {
        case stateName = "weather_state_name"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case temp = "the_temp"
    }
    
    let stateName: String
    let minTemp: Float
    let maxTemp: Float
    let temp: Float
}

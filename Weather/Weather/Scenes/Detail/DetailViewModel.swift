import UIKit

protocol DetailViewModeling {
    var cityName: String { get }
    var weather: String { get }
    var state: String { get }
    var minTemperature: String { get }
    var maxTemperature: String { get }
}

struct DetailViewModel: DetailViewModeling {
    let cityName: String
    let weather: String
    let state: String
    let minTemperature: String
    let maxTemperature: String
    
    init(
        cityName: String,
        weather: Float,
        state: String,
        minTemperature: Float,
        maxTemperature: Float
    ) {
        self.cityName = cityName
        self.weather = "\(Int(weather))º"
        self.state = state
        self.minTemperature = "L: \(Int(minTemperature))º"
        self.maxTemperature = "H: \(Int(maxTemperature))º"
    }
}

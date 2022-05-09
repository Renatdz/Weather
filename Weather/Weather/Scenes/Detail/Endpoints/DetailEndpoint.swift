import Foundation

enum DetailEndpoint: Endpoint {
    case fetchWeather(Int)
    
    var path: String {
        switch self {
        case .fetchWeather(let id):
            return "location/\(id)"
        }
    }
}

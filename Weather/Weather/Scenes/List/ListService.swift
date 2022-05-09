import Foundation

protocol ListServicing {
    func fetchCities() -> [City]
}

final class ListService {
}

extension ListService: ListServicing {
    func fetchCities() -> [City] {
        [
            City(id: 4118, name: "Toronto"),
            City(id: 2487956, name: "San Francisco"),
            City(id: 44418, name: "London"),
            City(id: 2459115, name: "New York"),
            City(id: 2379574, name: "Chicago"),
            City(id: 2442047, name: "Los Angeles"),
            City(id: 1118370, name: "Tokyo"),
            City(id: 1105779, name: "Sydney")
        ]
    }
}

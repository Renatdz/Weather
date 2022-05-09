import Foundation

protocol ListInteracting: AnyObject {
    func fetchCities()
    func selectCity(at index: Int)
}

final class ListInteractor {
    private let service: ListServicing
    private let presenter: ListPresenting
    
    private var cities: [City] = []

    init(service: ListServicing, presenter: ListPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

extension ListInteractor: ListInteracting {
    func fetchCities() {
        cities = service.fetchCities()
        presenter.present(cities: cities)
    }
    
    func selectCity(at index: Int) {
        let city = cities[index]
        presenter.select(city: city)
    }
}

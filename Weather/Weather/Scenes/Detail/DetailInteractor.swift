import Foundation

protocol DetailInteracting: AnyObject {
    func fetchWeather()
}

final class DetailInteractor {
    private let service: DetailServicing
    private let presenter: DetailPresenting
    private var city: City

    init(service: DetailServicing, presenter: DetailPresenting, city: City) {
        self.service = service
        self.presenter = presenter
        self.city = city
    }
}

extension DetailInteractor: DetailInteracting {
    func fetchWeather() {
        presenter.presentLoadingState()
        
        service.fetchWeather(id: city.id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let weather) where weather.consolidated.isEmpty:
                self.presenter.presentEmptyState()
                
            case .success(let weather):
                self.city.weather = weather
                self.presenter.presentSuccessState(withCityName: self.city.name, weather: weather)
                
            case .failure(let error):
                self.presenter.presentErrorState(withMessage: error.localizedDescription)
            }
        }
    }
}

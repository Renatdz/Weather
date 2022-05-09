import Foundation

protocol DetailPresenting: AnyObject {
    var viewController: DetailDisplaying? { get set }
    
    func presentLoadingState()
    func presentSuccessState(withCityName cityName: String, weather: Weather)
    func presentErrorState(withMessage message: String)
    func presentEmptyState()
}

final class DetailPresenter {
    weak var viewController: DetailDisplaying?
}

extension DetailPresenter: DetailPresenting {
    func presentLoadingState() {
        viewController?.displayLoadingState()
    }
    
    func presentSuccessState(withCityName cityName: String, weather: Weather) {
        guard let currentWeather = weather.consolidated.first else {
            return presentEmptyState()
        }
        
        let viewModel = DetailViewModel(
            cityName: cityName,
            weather: currentWeather.temp,
            state: currentWeather.stateName,
            minTemperature: currentWeather.minTemp,
            maxTemperature: currentWeather.maxTemp
        )
        viewController?.displaySuccessState(with: viewModel)
    }
    
    func presentErrorState(withMessage message: String) {
        let viewModel = ErrorViewModel(message: message)
        viewController?.displayErrorState(with: viewModel)
    }
    
    func presentEmptyState() {
        viewController?.displayEmptyState()
    }
}

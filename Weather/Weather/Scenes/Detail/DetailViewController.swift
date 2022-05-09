import UIKit

protocol DetailDisplaying: AnyObject {
    func displayLoadingState()
    func displaySuccessState(with viewModel: DetailViewModeling)
    func displayErrorState(with viewModel: ErrorViewModeling)
    func displayEmptyState()
}

final class DetailViewController: ViewController<DetailInteracting, DetailView> {
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        interactor.fetchWeather()
    }
}

extension DetailViewController: DetailDisplaying {
    func displayLoadingState() {
        rootView.revealLoadingState()
    }
    
    func displaySuccessState(with viewModel: DetailViewModeling) {
        title = viewModel.cityName
        rootView.revealSuccessState(with: viewModel)
    }
    
    func displayErrorState(with viewModel: ErrorViewModeling) {
        rootView.revealErrorState(with: viewModel)
    }
    
    func displayEmptyState() {
        rootView.revealEmptyState()
    }
}

import Foundation

protocol ListPresenting: AnyObject {
    var viewController: ListDisplaying? { get set }
    
    func present(cities: [City])
    func select(city: City)
}

final class ListPresenter {
    weak var viewController: ListDisplaying?
    private let coordinator: ListCoordinating

    init(coordinator: ListCoordinating) {
        self.coordinator = coordinator
    }
}

extension ListPresenter: ListPresenting {
    func present(cities: [City]) {
        let viewModels = cities
            .sorted()
            .map {
                ListViewModel(title: $0.name)
        }
        
        viewController?.display(viewModels: viewModels)
    }
    
    func select(city: City) {
        coordinator.perform(action: .detail(city))
    }
}

import UIKit

enum ListAction: Equatable {
    case detail(City)
}

protocol ListCoordinating: AnyObject {
    var viewController: UIViewController? { get set }

    func perform(action: ListAction)
}

final class ListCoordinator {
    weak var viewController: UIViewController?
}

extension ListCoordinator: ListCoordinating {
    func perform(action: ListAction) {
        switch action {
        case .detail(let city):
            let detailController = DetailFactory.make(with: city)
            viewController?.navigationController?.pushViewController(detailController, animated: true)
        }
    }
}

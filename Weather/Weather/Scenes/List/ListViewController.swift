import UIKit

protocol ListDisplaying: AnyObject {
    func display(viewModels: [ListViewModeling])
}

final class ListViewController: ViewController<ListInteracting, ListView> {
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("list.navigationTitle", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true
        
        interactor.fetchCities()
        
        bindViewActions()
    }
    
    // MARK: - Actions
    
    private func bindViewActions() {
        rootView.onSelectRowTouched = { [unowned self] index in
            self.interactor.selectCity(at: index)
        }
    }
}

// MARK: - ListDisplaying

extension ListViewController: ListDisplaying {
    func display(viewModels: [ListViewModeling]) {
        rootView.setup(with: viewModels)
    }
}

enum ListFactory {
    static func make() -> ListViewController {
        let service: ListServicing = ListService()
        let coordinator: ListCoordinating = ListCoordinator()
        let presenter: ListPresenting = ListPresenter(coordinator: coordinator)
        let interactor = ListInteractor(service: service, presenter: presenter)
        let viewController = ListViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}

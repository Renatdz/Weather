enum DetailFactory {
    static func make(with city: City) -> DetailViewController {
        let service: DetailServicing = DetailService()
        let presenter: DetailPresenting = DetailPresenter()
        let interactor = DetailInteractor(service: service, presenter: presenter, city: city)
        let viewController = DetailViewController(interactor: interactor)

        presenter.viewController = viewController

        return viewController
    }
}

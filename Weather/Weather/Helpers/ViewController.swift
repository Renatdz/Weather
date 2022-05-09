import UIKit

class ViewController<Interactor, V: UIView>: UIViewController, ViewLayoutable {
    // MARK: - Properties

    let interactor: Interactor

    var rootView = V()

    // MARK: - Initialization

    init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViewLayout()
    }

    // MARK: - ViewLayoutable

    func buildViewHierarchy() { }

    func buildViewConstraints() { }

    func additionalConfig() { }
}

// MARK: - ViewController where Interactor == Void

extension ViewController where Interactor == Void {
    convenience init(_ interactor: Interactor = ()) {
        self.init(interactor: interactor)
    }
}

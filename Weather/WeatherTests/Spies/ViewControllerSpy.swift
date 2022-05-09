import UIKit

final class ViewControllerSpy: UIViewController {
    private(set) var callPresentControllerCount = 0
    private(set) var callDismissControllerCount = 0
    private(set) var viewControllerPresented = UIViewController()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)? = nil
    ) {
        callPresentControllerCount += 1
        viewControllerPresented = viewControllerToPresent
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        callDismissControllerCount += 1
        super.dismiss(animated: flag, completion: completion)
    }
}

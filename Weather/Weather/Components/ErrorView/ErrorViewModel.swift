import Foundation

protocol ErrorViewModeling {
    var title: String { get }
    var message: String { get }
    var actionTitle: String { get }
}

struct ErrorViewModel: ErrorViewModeling {
    let title: String
    let message: String
    let actionTitle: String
    
    init(
        title: String = NSLocalizedString("error.title", comment: ""),
        message: String,
        actionTitle: String = NSLocalizedString("error.actionTitle", comment: "")
    ) {
        self.title = title
        self.message = message
        self.actionTitle = actionTitle
    }
}

import Foundation

protocol EmptyViewModeling {
    var title: String { get }
    var message: String { get }
}

struct EmptyViewModel: EmptyViewModeling {
    let title: String
    let message: String
}

extension EmptyViewModel {
    static let `default`: EmptyViewModeling = EmptyViewModel(
        title: NSLocalizedString("empty.title", comment: ""),
        message: NSLocalizedString("empty.message", comment: "")
    )
}

import Foundation
enum APIError: Error {
    case malformedUrl
    case internalServer
    case other(error: Error)
    
    var localizedDescription: String {
        switch self {
        case .malformedUrl:
            return NSLocalizedString("error.message.malformedUrl", comment: "")
        case .internalServer:
            return NSLocalizedString("error.message.internalServer", comment: "")
        case .other(let error):
            return error.localizedDescription
        }
    }
}

extension APIError: Equatable {
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.malformedUrl, .malformedUrl):
            return true
        case (.internalServer, .internalServer):
            return true
        case (.other(let lhsError), .other(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

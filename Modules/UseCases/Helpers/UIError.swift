import Foundation
import Models
import Resources

public enum UIError: Error {
    case unknown
    case wrongUrl
    case empty

    case developError(String)

    case server

    public var message: String? {
        let strings = Resources.strings

        switch self {
        case .unknown, .wrongUrl, .empty, .server:
            return ""

        case .developError(let message):
            return message
        }
    }

    var localizedDescription: String? {
        message
    }

    public var code: Int? {
        nil
    }
}

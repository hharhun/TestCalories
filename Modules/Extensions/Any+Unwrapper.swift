import Foundation

public extension Optional {
    var orEmpty: String {
        if let data = self as? String {
            return data
        } else if let data = self as? Int {
            return "\(data)"
        }

        return ""
    }
}

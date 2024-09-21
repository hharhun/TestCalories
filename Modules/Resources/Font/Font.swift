import UIKit

// MARK: - FontType

public enum FontType: String {
    case medium
    case semibold
    case bold
    case regular
}

// MARK: - Fonts used within the app

public extension _R {
    static let sfUIDisplay = "SFUIDisplay"

    static func font(
        of name: String = _R.sfUIDisplay,
        type: FontType = .regular,
        size: CGFloat
    ) -> UIFont {
        getFont(baseFontName: name, type: type, size: size)
    }
}

// MARK: - Convenience methods

extension _R {
    // swiftlint:disable force_unwrapping
    static func getFont(
        baseFontName: String,
        type: FontType,
        size: CGFloat
    ) -> UIFont {
        UIFont(name: "\(baseFontName)-\(type.rawValue)", size: size)!
    }

    // swiftlint:enable force_unwrapping
}

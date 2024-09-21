import Foundation

public enum Resources {
    public static var strings: _R.string.localizable { R.string.localizable.self }
    public static var images: _R.image { R.image.self }
    public static var colors: _R.color { R.color.self }

    // MARK: - Fonts

    public static func font(of name: String, type: FontType, size: CGFloat) -> UIFont {
        _R.font(of: name, type: type, size: size)
    }

    public static func font(type: FontType, size: CGFloat) -> UIFont {
        _R.font(type: type, size: size)
    }

    public static func font(of name: String, size: CGFloat) -> UIFont {
        _R.font(of: name, size: size)
    }

    public static func font(size: CGFloat) -> UIFont {
        _R.font(size: size)
    }
}

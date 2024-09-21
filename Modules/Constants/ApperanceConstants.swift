public protocol AppearanceConstants {}

public extension AppearanceConstants {
    var clearColor: UIColor { .clear }
    var whiteColor: UIColor { .white }
    var blackColor: UIColor { .black }
}

public struct AppearanceConstantsWrapper<Base>: AppearanceConstants {
    private let base: Base

    init(base: Base) {
        self.base = base
    }
}

public protocol AppearanceConstantsInterface: AnyObject {}

public extension AppearanceConstantsInterface {
    var appearance: AppearanceConstantsWrapper<Self> { AppearanceConstantsWrapper(base: self) }
}

extension UIView: AppearanceConstantsInterface {}
extension UIViewController: AppearanceConstantsInterface {}

public protocol GridConstants {}

public extension GridConstants {
    var zero: CGFloat { .zero }
    var space1: CGFloat { 1 }
    var space2: CGFloat { 2 }
    var space4: CGFloat { 4 }
    var space8: CGFloat { 8 }
    var space10: CGFloat { 10 }
    var space12: CGFloat { 12 }
    var space16: CGFloat { 16 }
    var space20: CGFloat { 20 }
    var space24: CGFloat { 24 }
    var space28: CGFloat { 28 }
    var space32: CGFloat { 32 }
    var space36: CGFloat { 36 }
    var space40: CGFloat { 40 }
    var space44: CGFloat { 44 }
    var space48: CGFloat { 48 }
    var space52: CGFloat { 52 }
    var space56: CGFloat { 56 }
    var space60: CGFloat { 60 }
    var space64: CGFloat { 64 }
    var space68: CGFloat { 68 }
    var space72: CGFloat { 72 }
    var space76: CGFloat { 76 }
    var space80: CGFloat { 80 }
    var space120: CGFloat { 120 }
    var space160: CGFloat { 160 }
    var space200: CGFloat { 200 }
    var space260: CGFloat { 260 }
}

public struct GridConstantsWrapper<Base>: GridConstants {
    private let base: Base

    init(_ base: Base) {
        self.base = base
    }
}

public protocol GridConstantsInterface: AnyObject {}

public extension GridConstantsInterface {
    var grid: GridConstantsWrapper<Self> { GridConstantsWrapper(self) }
}

extension UIView: GridConstantsInterface {}
extension UIViewController: GridConstantsInterface {}

public protocol DataConstants {}

public extension DataConstants {}

public struct DataConstantsWrapper<Base>: DataConstants {
    private let base: Base

    init(_ base: Base) {
        self.base = base
    }
}

public protocol DataConstantsInterface: AnyObject {}

public extension DataConstantsInterface {
    var data: DataConstantsWrapper<Self> { DataConstantsWrapper(self) }
}

extension UIView: DataConstantsInterface {}
extension UIViewController: DataConstantsInterface {}

import UIKit

open class BaseCoordinator: NSObject, Coordinator {
    public var onComplete: ((Coordinator) -> Void)?

    // MARK: - Properties

    private var _children: [Coordinator] = []

    public let navigationController: UINavigationController?

    // MARK: - Coordinator Properties

    open var rootViewController: UIViewController? {
        navigationController
    }

    open var children: [Coordinator] {
        _children
    }

    // MARK: - Constructor

    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    // MARK: - Methods

    public func add(child coordinator: Coordinator) {
        _children.append(coordinator)
    }

    public func remove(child coordinator: Coordinator) {
        _children = _children.filter { coordinator !== $0 }
    }

    // MARK: - Coordinator Methods

    //  swiftlint:disable unavailable_function
    open func start() {
        fatalError("this method must be overridden")
    }

    //  swiftlint:enable unavailable_function
}

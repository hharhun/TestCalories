import Foundation
import Resources

// MARK: - RootAssembly

public protocol RootAssembly {
    func makeMainNavigation() -> UINavigationController

    func makeNewNavigation() -> UINavigationController
}

// MARK: - RootAssemblyImpl

public class RootAssemblyImpl: RootAssembly {
    public init() {}

    public func makeMainNavigation() -> UINavigationController {
        makeNewNavigation()
    }

    public func makeNewNavigation() -> UINavigationController {
        UINavigationController()
    }
}

import _Main
import Core
import UIKit
import UseCases

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private var coordinator: Coordinator!

    private lazy var rootAssembly: RootAssembly = RootAssemblyImpl()

    private lazy var useCasesAssembly: UseCasesAssembly = UseCasesAssemblyImpl()

    private var assembly: BaseAssembly?

    func scene(
        _ scene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        setupAuth()
    }

    // MARK: - Private methods

    func setupAuth(window: UIWindow) {
        let mainAssembly = mainAssembly(window: window)
        coordinator = mainAssembly.coordinator()

        window.rootViewController = coordinator.rootViewController
        self.window = window
        window.makeKeyAndVisible()
        coordinator.start()

        assembly = mainAssembly
    }

    func setupAuth() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        window = UIWindow(windowScene: windowScene)

        guard let window = window else { return }

        setupAuth(window: window)
    }

    // MARK: - Assembly

    func mainAssembly(window: UIWindow) -> BaseAssembly {
        MainAssemblyImpl(
            rootAssembly: rootAssembly,
            useCasesAssembly: useCasesAssembly,
            window: window
        )
    }

    // MARK: -

    func sceneDidDisconnect(_: UIScene) {}

    func sceneDidBecomeActive(_: UIScene) {}

    func sceneWillResignActive(_: UIScene) {}

    func sceneWillEnterForeground(_: UIScene) {}

    func sceneDidEnterBackground(_: UIScene) {}
}

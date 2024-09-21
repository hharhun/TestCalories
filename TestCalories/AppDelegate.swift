import Resources
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupNavigation()
        setupSearchBar()

        return true
    }

    private func setupSearchBar() {
        // Remove the icon, which is located in the left view
        UITextField.appearance(whenContainedInInstancesOf: [UISearchTextField.self]).leftView = nil

        // Give some left padding between the edge of the search bar and the text the user enters
        // UISearchTextField.appearance().searchTextPositionAdjustment = UIOffset(horizontal: 10, vertical: .zero)
    }

    private func setupNavigation() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().tintColor = Resources.colors.c351F0E()
        // Hide backButton text
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.clear],
            for: .normal
        )
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.clear],
            for: UIControl.State.highlighted
        )

        let font = Resources.font(type: .medium, size: 18)
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: Resources.colors.c351F0E() ?? .clear
        ]
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }

    func application(
        _: UIApplication,
        didDiscardSceneSessions _: Set<UISceneSession>
    ) {}

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {}
}

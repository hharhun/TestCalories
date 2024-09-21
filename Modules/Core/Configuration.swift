import Foundation

public struct Configuration {
    private enum Constants {
        enum PlistKeys {
            static let bundleShortVersion = "CFBundleShortVersionString"
            static let bundleBuildVersion = "CFBundleVersion"
            static let bundleURLTypes = "CFBundleURLTypes"
            static let bundleURLName = "CFBundleURLName"
            static let bundleURLSchemes = "CFBundleURLSchemes"
            static let bundleAppName = "CFBundleName"
        }
    }

    // MARK: Public

    public static let shared = Configuration.readConfig()

    public let appAndBuildVersion: String
    public let appVersion: String
    public let appBundle: String
    public let appName: String

    // MARK: Private

    private static func readConfig() -> Configuration {
        guard let infoDict = Bundle.main.infoDictionary else {
            fatalError("Unable to read config at info.plist file ")
        }
        let keys = Constants.PlistKeys.self
        guard
            let shortVersion: String = Convert.get(key: keys.bundleShortVersion, from: infoDict),
            let buildVersion: String = Convert.get(key: keys.bundleBuildVersion, from: infoDict),
            let appBundle: String = Convert.from(Bundle.main.bundleIdentifier),
            let appName: String = Convert.get(key: keys.bundleAppName, from: infoDict)
        else {
            fatalError("Unable to convert config")
        }

        return Configuration(
            appAndBuildVersion: "\(shortVersion)(\(buildVersion))",
            appVersion: shortVersion,
            appBundle: appBundle,
            appName: appName
        )
    }
}

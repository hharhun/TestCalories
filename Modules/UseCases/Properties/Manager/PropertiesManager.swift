import Core
import Foundation
import KeychainAccess

// MARK: - PropertiesManager

class PropertiesManager {
    enum `Type` {
        case secure
        case unsecure
    }

    private let userDefaults: UserDefaults
    private let keychain: Keychain
    private let type: Type

    init(type: Type, name: String = Configuration.shared.appName) {
        self.type = type
        keychain = Keychain(service: name)
        userDefaults = UserDefaults(suiteName: name) ?? .standard
    }

    subscript<Result: Codable>(key: String) -> Result? {
        get {
            guard let value: Result = value(for: key) else {
                return nil
            }
            return value
        }
        set {
            do {
                try set(value: newValue, for: key)
            } catch {}
        }
    }
}

// MARK: -

extension PropertiesManager {
    func remove(for key: String) {
        switch type {
        case .secure:
            try? keychain.remove(key)

        case .unsecure:
            userDefaults.set(nil, forKey: key)
        }
    }

    func value<Result: Decodable>(for key: String) -> Result? {
        var codableValue: String?
        switch type {
        case .secure:
            codableValue = try? keychain.get(key)

        case .unsecure:
            codableValue = userDefaults.value(forKey: key) as? String
        }
        return codableValue?.parse(to: Result.self)
    }

    func set<Result: Encodable>(value: Result?, for key: String) throws {
        let data = try JSONEncoder().encode(value)
        let codableValue = String(decoding: data, as: UTF8.self)

        switch type {
        case .secure:
            try keychain.set(codableValue, key: key)

        case .unsecure:
            userDefaults.set(codableValue, forKey: key)
        }
    }
}

// MARK: - Parsing

extension String {
    func parse<D>(to type: D.Type) -> D? where D: Decodable {
        guard let data: Data = data(using: .utf8) else { return nil }
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            return nil
        }
    }
}

import Foundation

public struct NetworkError: Codable, Error {
    // MARK: Public

    public let message: String?
    public var code: Int

    // MARK: Lifecycle

    public init(message: String?, code: Int) {
        self.message = message
        self.code = code
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        do {
            code = try container.decode(Int.self, forKey: .code)
        } catch {
            code = try Int(container.decode(String.self, forKey: .code)) ?? 0
        }

        do {
            message = try container.decode(String.self, forKey: .message)
        } catch {
            message = nil
        }
    }

    // MARK: Internal

    func encode(with aCoder: NSCoder) {
        aCoder.encode(message, forKey: "message")
        aCoder.encode(code, forKey: "code")
    }
}

// MARK: - Constants

public extension NetworkError {
    static var decodeError: NetworkError {
        NetworkError(message: "Decoding error", code: -100)
    }
}

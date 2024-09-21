public struct ErrorData {
    public let title: String
    public let description: String
}

// MARK: - Parsing

extension ErrorData: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case description
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let title = try container.decode(String.self, forKey: CodingKeys.title)
        let description = try container.decode(String.self, forKey: CodingKeys.description)

        self.init(title: title, description: description)
    }

    public func encode(to _: Encoder) throws {}
}

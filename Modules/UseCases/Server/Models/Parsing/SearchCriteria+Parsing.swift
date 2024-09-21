import Models

extension SearchCriteria: Codable {
    enum CodingKeys: String, CodingKey {
        case query
        case pageNumber
        case numberOfResultsPerPage
        case pageSize
        case totalPages
        case foodCategory
        case brandName = "brandOwner"
    }

    // MARK: - Init

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let query = try? container.decode(String.self, forKey: CodingKeys.query)
        let pageNumber = try? container.decode(Int.self, forKey: CodingKeys.pageNumber)
        let numberOfResultsPerPage = try? container.decode(Int.self, forKey: CodingKeys.numberOfResultsPerPage)
        let pageSize = try? container.decode(Int.self, forKey: CodingKeys.pageSize)

        let foodCategory = try? container.decode(String.self, forKey: CodingKeys.foodCategory)
        let brandName = try? container.decode(String.self, forKey: CodingKeys.brandName)

        self.init(
            query: query,
            pageNumber: pageNumber,
            numberOfResultsPerPage: numberOfResultsPerPage,
            pageSize: pageSize,
            foodCategory: foodCategory,
            brandName: brandName
        )
    }

    public func encode(to encoder: Encoder) throws {}
}

import Models

extension Food: Codable {
    enum CodingKeys: String, CodingKey {
        case fdcID = "fdcId"
        case description
        case foodNutrients
        case commonNames
        case scientificName
        case foodCategory
        case foodCategoryID = "foodCategoryId"
        case brandOwner
    }

    // MARK: - Init

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let fdcID = try? container.decode(Int.self, forKey: CodingKeys.fdcID)
        let description = try? container.decode(String.self, forKey: CodingKeys.description)
        let foodNutrients = try? container.decode([FoodNutrient].self, forKey: CodingKeys.foodNutrients)

        let commonNames = try? container.decode(String.self, forKey: CodingKeys.commonNames)
        let scientificName = try? container.decode(String.self, forKey: CodingKeys.scientificName)

        let foodCategory = try? container.decode(String.self, forKey: CodingKeys.foodCategory)
        let foodCategoryID = try? container.decode(Int.self, forKey: CodingKeys.foodCategoryID)

        let brandOwner = try? container.decode(String.self, forKey: CodingKeys.brandOwner)

        self.init(
            fdcID: fdcID,
            commonNames: commonNames?.isEmpty ?? false ? nil : commonNames,
            scientificName: scientificName?.isEmpty ?? false ? nil : scientificName,
            description: description,
            foodNutrients: foodNutrients,
            foodCategory: foodCategory,
            foodCategoryID: foodCategoryID,
            brandOwner: brandOwner
        )
    }

    public func encode(to encoder: Encoder) throws {}
}

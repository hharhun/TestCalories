import Foundation

public struct Food {
    public let fdcID: Int?
    public let commonNames: String?
    public let scientificName: String?
    public let description: String?
    public let foodNutrients: [FoodNutrient]?
    public let foodCategory: String?
    public let foodCategoryID: Int?
    public let brandOwner: String?

    public init(
        fdcID: Int? = nil,
        commonNames: String? = nil,
        scientificName: String? = nil,
        description: String? = nil,
        foodNutrients: [FoodNutrient]? = nil,
        foodCategory: String?,
        foodCategoryID: Int?,
        brandOwner: String?
    ) {
        self.fdcID = fdcID
        self.commonNames = commonNames
        self.scientificName = scientificName
        self.description = description
        self.foodNutrients = foodNutrients
        self.foodCategory = foodCategory
        self.foodCategoryID = foodCategoryID
        self.brandOwner = brandOwner
    }
}

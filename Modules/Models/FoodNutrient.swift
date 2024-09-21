import Foundation

public struct FoodNutrient {
    public enum Constants {
        public static var energyNutrientID: Int { 1008 }
    }

    public let nutrientID: Int?
    public let nutrientName: String?
    public let nutrientNumber: String?
    public let unitName: UnitName?
    public let value: Double?
    public let rank: Int?
    public let indentLevel: Int?
    public let foodNutrientID: Int?
    public let derivationCode: DerivationCode?
    public let derivationDescription: String?
    public let derivationID: Int?
    public let foodNutrientSourceID: Int?
    public let foodNutrientSourceCode: String?
    public let foodNutrientSourceDescription: String?
    public let dataPoints: Int?
    public let min: Double?
    public let max: Double?

    public init(
        nutrientID: Int? = nil,
        nutrientName: String? = nil,
        nutrientNumber: String? = nil,
        unitName: UnitName? = nil,
        value: Double? = nil,
        rank: Int? = nil,
        indentLevel: Int? = nil,
        foodNutrientID: Int? = nil,
        derivationCode: DerivationCode? = nil,
        derivationDescription: String? = nil,
        derivationID: Int? = nil,
        foodNutrientSourceID: Int? = nil,
        foodNutrientSourceCode: String? = nil,
        foodNutrientSourceDescription: String? = nil,
        dataPoints: Int? = nil,
        min: Double? = nil,
        max: Double? = nil
    ) {
        self.nutrientID = nutrientID
        self.nutrientName = nutrientName
        self.nutrientNumber = nutrientNumber
        self.unitName = unitName
        self.value = value
        self.rank = rank
        self.indentLevel = indentLevel
        self.foodNutrientID = foodNutrientID
        self.derivationCode = derivationCode
        self.derivationDescription = derivationDescription
        self.derivationID = derivationID
        self.foodNutrientSourceID = foodNutrientSourceID
        self.foodNutrientSourceCode = foodNutrientSourceCode
        self.foodNutrientSourceDescription = foodNutrientSourceDescription
        self.dataPoints = dataPoints
        self.min = min
        self.max = max
    }
}

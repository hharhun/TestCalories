import Models

extension FoodNutrient: Codable {
    enum CodingKeys: String, CodingKey {
        case nutrientID = "nutrientId"
        case nutrientName
        case nutrientNumber
        case unitName
        case value
        case rank
        case indentLevel
        case foodNutrientID = "foodNutrientId"
        case derivationCode
        case derivationDescription
        case derivationID = "derivationId"
        case foodNutrientSourceID = "foodNutrientSourceId"
        case foodNutrientSourceCode
        case foodNutrientSourceDescription
        case dataPoints
        case min
        case max
    }

    // MARK: - Init

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let nutrientID = try? container.decode(Int.self, forKey: CodingKeys.nutrientID)
        let nutrientName = try? container.decode(String.self, forKey: CodingKeys.nutrientName)
        let nutrientNumber = try? container.decode(String.self, forKey: CodingKeys.nutrientNumber)
        let unitName = try? container.decode(UnitName.self, forKey: CodingKeys.unitName)
        let value = try? container.decode(Double.self, forKey: CodingKeys.value)
        let rank = try? container.decode(Int.self, forKey: CodingKeys.rank)
        let indentLevel = try? container.decode(Int.self, forKey: CodingKeys.indentLevel)
        let foodNutrientID = try? container.decode(Int.self, forKey: CodingKeys.foodNutrientID)
        let derivationCode = try? container.decode(DerivationCode.self, forKey: CodingKeys.derivationCode)
        let derivationDescription = try? container.decode(String.self, forKey: CodingKeys.derivationDescription)
        let derivationID = try? container.decode(Int.self, forKey: CodingKeys.derivationID)
        let foodNutrientSourceID = try? container.decode(Int.self, forKey: CodingKeys.foodNutrientSourceID)
        let foodNutrientSourceCode = try? container.decode(String.self, forKey: CodingKeys.foodNutrientSourceCode)
        let foodNutrientSourceDescription = try? container.decode(
            String.self, forKey: CodingKeys.foodNutrientSourceDescription
        )
        let dataPoints = try? container.decode(Int.self, forKey: CodingKeys.dataPoints)
        let min = try? container.decode(Double.self, forKey: CodingKeys.min)
        let max = try? container.decode(Double.self, forKey: CodingKeys.max)

        self.init(
            nutrientID: nutrientID,
            nutrientName: nutrientName,
            nutrientNumber: nutrientNumber,
            unitName: unitName,
            value: value,
            rank: rank,
            indentLevel: indentLevel,
            foodNutrientID: foodNutrientID,
            derivationCode: derivationCode,
            derivationDescription: derivationDescription,
            derivationID: derivationID,
            foodNutrientSourceID: foodNutrientSourceID,
            foodNutrientSourceCode: foodNutrientSourceCode,
            foodNutrientSourceDescription: foodNutrientSourceDescription,
            dataPoints: dataPoints,
            min: min,
            max: max
        )
    }

    public func encode(to encoder: Encoder) throws {}
}

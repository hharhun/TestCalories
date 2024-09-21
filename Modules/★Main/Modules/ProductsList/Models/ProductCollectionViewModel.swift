import Models
import Resources
import UIComponents
import UIKit

// MARK: - ProductCollectionViewModel

struct ProductCollectionViewModel: ConfigurableCollectionViewCellModel {
    var viewCellType: String {
        NSStringFromClass(ProductCollectionViewCell.self)
    }

    let id: String

    let title: String
    let description: String?

    init(
        food: Food
    ) {
        id = food.fdcID == nil ? UUID().uuidString : String(food.fdcID.orEmpty)
        title = food.commonNames ?? food.scientificName ?? Resources.strings.productsListNoName()

        var energy: String?
        let energyNutrient = food.foodNutrients?.first(where: {
            $0.nutrientID == FoodNutrient.Constants.energyNutrientID
        })
        if let unitName = energyNutrient?.unitName, let rank = energyNutrient?.rank {
            energy = [unitName.rawValue.lowercased(), String(rank)].joined(separator: ": ")
        }

        description = [food.brandOwner, energy].compactMap { $0 }.joined(separator: " - ")
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(description)
    }
}

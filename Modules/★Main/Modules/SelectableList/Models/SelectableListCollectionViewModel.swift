import UIComponents
import UIKit

// MARK: - SelectableListCollectionViewModel

struct SelectableListCollectionViewModel: ConfigurableCollectionViewCellModel, SelectedViewCellModel {
    var viewCellType: String {
        NSStringFromClass(SelectableListCollectionViewCell.self)
    }

    let id: String

    let title: String

    var isSelected: Bool

    init(
        id: String = UUID().uuidString,
        title: String,
        isSelected: Bool
    ) {
        self.id = id
        self.title = title
        self.isSelected = isSelected
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(isSelected)
    }
}

import Core
import Foundation
import Models
import UseCases

// MARK: - SelectableListInputInterface

protocol SelectableListInputInterface: AnyObject, BaseInputInterface {}

// MARK: - SelectableListOutputInterface

protocol SelectableListOutputInterface: BaseOutputInterface {
    func didUpdatedSelectedItems(id: String, items: [String])
}

// MARK: - SelectableListInputInterface

final class SelectableListConfigModel: BaseConfigModel<
    SelectableListInputInterface,
    SelectableListOutputInterface
> {
    let id: String

    var list: [(item: String, isSelected: Bool)]

    init(
        output: SelectableListOutputInterface?,
        id: String,
        list: [String],
        selectedList: [String]
    ) {
        self.id = id
        self.list = list.compactMap {
            (item: $0, isSelected: selectedList.contains($0))
        }

        super.init(output: output)
    }
}

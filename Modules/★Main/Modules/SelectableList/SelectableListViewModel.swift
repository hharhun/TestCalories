import Core
import Models
import Resources
import UIComponents
import UseCases

// MARK: - SelectableListViewModelInterface

protocol SelectableListViewModelInterface: BaseViewModelInterface {
    var collectionData: [CollectionSection] { get }

    func didTapCell(indexPath: IndexPath)
    func setPreferredContentSize(size: CGSize)
}

// MARK: - SelectableListViewController

final class SelectableListViewModel: BaseViewModel<
    SelectableListViewController,
    SelectableListViewInterface,
    SelectableListConfigModel
> {
    var collectionData: [CollectionSection] = []

    override func viewLoaded() {
        super.viewLoaded()

        setupData()
    }

    private func setupData() {
        collectionData = [
            CollectionSection(
                header: EmptyHeaderViewModel(),
                rows: config.list.compactMap { item in
                    CollectionRow(
                        model: SelectableListCollectionViewModel(
                            title: item.item,
                            isSelected: item.isSelected
                        )
                    )
                }
            )
        ]
        view.reloadData()
    }
}

// MARK: - SelectableListViewModelInterface

extension SelectableListViewModel: SelectableListViewModelInterface {
    func didTapCell(indexPath: IndexPath) {
        let item = config.list[indexPath.row]
        var isSelected = item.isSelected
        isSelected.toggle()
        config.list[indexPath.row] = (item.item, isSelected)

        config.output?.didUpdatedSelectedItems(
            id: config.id, items: config.list.compactMap { $0.isSelected ? $0.item : nil }
        )
    }

    func setPreferredContentSize(size: CGSize) {
        controller.setPreferredContentSize(size: size)
    }
}

// MARK: - SelectableListInputInterface

extension SelectableListViewModel: SelectableListInputInterface {}

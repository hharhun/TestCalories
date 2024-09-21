import Core
import Models
import UseCases

final class MainCoordinator: BaseCoordinator {
    private weak var assembly: MainAssembly?

    private weak var productsListInput: ProductsListInputInterface?

    init(assembly: MainAssembly, navigation: UINavigationController?) {
        self.assembly = assembly

        super.init(navigationController: navigation)
    }

    override func start() {
        guard let productsList = assembly?.makeProductsList(output: self) else { return }
        productsListInput = productsList.input
        navigationController?.pushViewController(productsList.vc, animated: true)
    }
}

// MARK: - ProductsListOutputInterface

extension MainCoordinator: ProductsListOutputInterface {
    func showSelectableList(
        id: String,
        list: [String],
        selectedList: [String],
        rect: CGRect,
        sourceView: UIView
    ) {
        guard let selectableList = assembly?.makeSelectableList(
            output: self,
            id: id,
            list: list,
            selectedList: selectedList,
            rect: rect,
            sourceView: sourceView
        ) else { return }
        selectableList.presentationController?.delegate = self
        navigationController?.present(selectableList, animated: true)
    }
}

// MARK: - SelectableListOutputInterface

extension MainCoordinator: SelectableListOutputInterface {
    func didUpdatedSelectedItems(id: String, items: [String]) {
        productsListInput?.didUpdatedSelectedItems(id: id, items: items)
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension MainCoordinator: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle {
        .none
    }

    func popoverPresentationControllerShouldDismissPopover(
        _ popoverPresentationController: UIPopoverPresentationController
    ) -> Bool {
        productsListInput?.didHideSelectableView()
        return true
    }
}

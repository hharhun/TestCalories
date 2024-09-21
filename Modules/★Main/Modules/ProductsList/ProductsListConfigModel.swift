import Core
import Foundation
import UseCases

// MARK: - ProductsListInputInterface

protocol ProductsListInputInterface: AnyObject, BaseInputInterface {
    func didHideSelectableView()
    func didUpdatedSelectedItems(id: String, items: [String])
}

// MARK: - ProductsListOutputInterface

protocol ProductsListOutputInterface: BaseOutputInterface {
    func showSelectableList(
        id: String,
        list: [String],
        selectedList: [String],
        rect: CGRect,
        sourceView: UIView
    )
}

// MARK: - ProductsListInputInterface

final class ProductsListConfigModel: BaseConfigModel<ProductsListInputInterface, ProductsListOutputInterface> {
    let foodsUseCase: FoodsUseCase

    init(
        output: ProductsListOutputInterface?,
        foodsUseCase: FoodsUseCase
    ) {
        self.foodsUseCase = foodsUseCase

        super.init(output: output)
    }
}

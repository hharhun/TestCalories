import Constants
import Core
import Extensions
import Resources
import UIKit

// MARK: - Constants

private extension GridConstants {}

private extension DataConstants {
    var title: String? { Resources.strings.productsListTitle() }
}

private extension AppearanceConstants {
    var backgroundColor: UIColor? { Resources.colors.cF8EAE0() }
}

// MARK: - ProductsListViewInterface

protocol ProductsListViewControllerInterface: BaseViewControllerInterface {}

// MARK: - ProductsListViewController

final class ProductsListViewController: BaseViewController<ProductsListViewInterface, ProductsListViewModelInterface> {
    override func setupUI() {
        super.setupUI()

        title = data.title

        view.backgroundColor = appearance.backgroundColor
    }

    override func setupConstraints() {
        super.setupConstraints()

        pinContentViewFull(toSafeArea: true)
    }
}

// MARK: - ProductsListViewController

extension ProductsListViewController: ProductsListViewControllerInterface {}

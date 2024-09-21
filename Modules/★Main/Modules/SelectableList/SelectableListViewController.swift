import Constants
import Core
import Extensions
import Resources
import UIComponents
import UIKit

// MARK: - Constants

private extension GridConstants {
    var minWidth: CGFloat { 240 }
    var minHeight: CGFloat { 40 }
}

private extension DataConstants {}

private extension AppearanceConstants {
    var backgroundColor: UIColor? { Resources.colors.cFFFAF7() }
}

// MARK: - SelectableListViewInterface

protocol SelectableListViewControllerInterface: BaseViewControllerInterface {
    func setPreferredContentSize(size: CGSize)
}

// MARK: - SelectableListViewController

final class SelectableListViewController: BaseViewController<
    SelectableListViewInterface,
    SelectableListViewModelInterface
> {
    override func setupConstraints() {
        super.setupConstraints()

        pinContentViewFull(toSafeArea: false)
    }

    override func setupUI() {
        super.setupUI()

        view.backgroundColor = appearance.backgroundColor
    }
}

// MARK: - SelectableListViewController

extension SelectableListViewController: SelectableListViewControllerInterface {
    func setPreferredContentSize(size: CGSize) {
        preferredContentSize = CGSize(
            width: grid.minWidth,
            height: max(grid.minHeight, size.height)
        )
    }
}

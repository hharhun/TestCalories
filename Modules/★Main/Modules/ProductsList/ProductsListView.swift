import Constants
import Core
import Extensions
import Resources
import SnapKit
import Then
import UIComponents
import UIKit

// MARK: - Constants

private extension GridConstants {}

private extension DataConstants {
    var searchPlaceholder: String { Resources.strings.productsListSearch() }

    var clearIcon: UIImage? { Resources.images.clearSearch() }

    var brandTitle: String? { Resources.strings.productsListBrandName() }
    var categoryTitle: String? { Resources.strings.productsListCategory() }
}

private extension AppearanceConstants {
    var backgroundCollectionColor: UIColor? { .clear }

    var moveCollectionDuration: TimeInterval { 0.3 }

    var searchColor: UIColor? { Resources.colors.c2A2A2A() }
    var searchFont: UIFont? { Resources.font(type: .regular, size: 14) }
    var searchBackgroundColor: UIColor? { Resources.colors.cFFF9F5() }

    var clearColor: UIColor? { Resources.colors.cA8A8A8() }
}

// MARK: - ProductsListViewInterface

protocol ProductsListViewInterface: BaseViewInterface {
    func reloadData()

    func setupSelectionState(type: ProductsListViewModel.SelectableType, state: SelectableButton.SelectionState)
}

// MARK: - ProductsListView

final class ProductsListView: BaseView<ProductsListViewModel> {
    private lazy var searchTextField = UISearchTextField().then {
        $0.font = appearance.searchFont
        $0.backgroundColor = appearance.searchBackgroundColor
        $0.clipsToBounds = true
        $0.layer.cornerRadius = grid.space16
        $0.placeholder = data.searchPlaceholder
        $0.borderStyle = .none
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        if let clearButton = $0.value(forKey: "_clearButton") as? UIButton {
            clearButton.setImage(data.clearIcon, for: .normal)
            clearButton.tintColor = appearance.clearColor
        }
        $0.textColor = appearance.searchColor
        $0.leftView = nil
    }

    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.delegate = self
        $0.backgroundColor = appearance.backgroundCollectionColor
        $0.register(class: ProductCollectionViewCell.self)
        $0.showsVerticalScrollIndicator = false
    }

    private lazy var collectionDataSource = getCollectionDataSource()

    private lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = grid.space8
        $0.distribution = .fillEqually
    }

    private lazy var brandSelectableButton = SelectableButton(
        id: ProductsListViewModel.SelectableType.brand.rawValue
    ).then {
        $0.titleLabel.text = data.brandTitle
        $0.delegate = self
    }

    private lazy var categorySelectableButton = SelectableButton(
        id: ProductsListViewModel.SelectableType.category.rawValue
    ).then {
        $0.titleLabel.text = data.categoryTitle
        $0.delegate = self
    }

    override func setupUI() {
        addSubviews(
            [
                searchTextField,
                stackView,
                collectionView
            ]
        )
        stackView.addArrangedSubviews([brandSelectableButton, categorySelectableButton])

        collectionView.dataSource = collectionDataSource
        collectionView.setCollectionViewLayout(getCollectionLayout(), animated: false)
    }

    override public func setupConstraints() {
        searchTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(grid.space8)
            $0.height.equalTo(grid.space40)
            $0.leading.trailing.equalToSuperview().inset(grid.space16)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).inset(-grid.space8)
            $0.height.equalTo(grid.space32)
            $0.leading.trailing.equalToSuperview().inset(grid.space16)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).inset(-grid.space12)
            $0.leading.trailing.equalToSuperview().inset(grid.space12)
            $0.bottom.equalToSuperview()
        }
    }

    private func getCollectionDataSource() -> CollectionDataSource {
        let dataSource: CollectionDataSource = .init(
            collectionView: collectionView
        ) { collectionView, indexPath, row -> UICollectionViewCell? in
            row.model.configure(collectionView: collectionView, for: indexPath)
        }
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            self?.viewModel.collectionData[indexPath.section].model(kind: kind)?.configure(
                collectionView: collectionView,
                indexPath: indexPath,
                kind: kind
            )
        }
        return dataSource
    }

    func getCollectionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
            .verticalList()
        })
    }

    override func keyboardDidChangeState(_ state: KeyboardState) {
        switch state {
        case .didShow(let frame):
            collectionView.contentInset = UIEdgeInsets(
                top: .zero, left: .zero, bottom: frame.height, right: .zero
            )

        case .didHide:
            UIView.animate(withDuration: appearance.moveCollectionDuration, animations: {
                self.collectionView.contentInset = .zero
            })

        default:
            break
        }
    }

    @objc
    func textFieldDidChange(_ textField: UITextField) {
        viewModel.search(with: textField.text.orEmpty)
    }
}

// MARK: - ProductsListViewInterface

extension ProductsListView: ProductsListViewInterface {
    func reloadData() {
        var snapshot = CollectionSnapshot()
        for section in viewModel.collectionData {
            snapshot.appendSections([section])
            snapshot.appendItems(section.rowsModels, toSection: section)
        }
        collectionDataSource.apply(snapshot, animatingDifferences: true)
    }

    func setupSelectionState(type: ProductsListViewModel.SelectableType, state: SelectableButton.SelectionState) {
        switch type {
        case .brand:
            brandSelectableButton.selectionState = state

        case .category:
            categorySelectableButton.selectionState = state
        }
    }
}

// MARK: - UICollectionViewDelegate

extension ProductsListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didTapCell(indexPath: indexPath)
    }

    func collectionView(
        _ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath
    ) {
        guard
            indexPath.row == (viewModel.collectionData.first?.rowsModels.count ?? .zero) - Int(grid.space10)
        else { return }
        viewModel.needLoadMore()
    }
}

// MARK: - SelectableButtonDelegate

extension ProductsListView: SelectableButtonDelegate {
    func didTapSelectableButton(_ button: SelectableButton) {
        guard let type = ProductsListViewModel.SelectableType(rawValue: button.id) else { return }

        let superview = self

        var sourceView = UIView()

        switch type {
        case .brand:
            sourceView = brandSelectableButton

        case .category:
            sourceView = categorySelectableButton
        }

        viewModel.select(type: type, rect: sourceView.bounds, sourceView: sourceView)
    }

    func didTapClearSelectableButton(_ button: SelectableButton) {
        guard let type = ProductsListViewModel.SelectableType(rawValue: button.id) else { return }
        viewModel.clear(type: type)
    }
}

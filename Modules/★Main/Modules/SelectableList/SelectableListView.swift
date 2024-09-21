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

private extension DataConstants {}

private extension AppearanceConstants {}

// MARK: - SelectableListViewInterface

public protocol SelectableListViewInterface: BaseViewInterface {
    func reloadData()
}

// MARK: - SelectableListView

final class SelectableListView: BaseView<SelectableListViewModel> {
    private lazy var collectionView = IntrinsicCollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.delegate = self
        $0.register(class: SelectableListCollectionViewCell.self)
        $0.register(
            supplementaryClass: EmptyHeaderView.self,
            kind: UICollectionView.elementKindSectionHeader
        )
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.intrinsicDelegate = self
        $0.allowsMultipleSelection = true
    }

    private lazy var collectionDataSource = getCollectionDataSource()

    override func setupUI() {
        addSubview(collectionView)

        collectionView.dataSource = collectionDataSource
        collectionView.setCollectionViewLayout(getCollectionLayout(), animated: false)
    }

    override func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(grid.space8)
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func getCollectionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(sectionProvider: { (_: Int, _: NSCollectionLayoutEnvironment) in
            .verticalList()
        })
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
}

// MARK: - SelectableListViewInterface

extension SelectableListView: SelectableListViewInterface {
    func reloadData() {
        var snapshot = CollectionSnapshot()
        for section in viewModel.collectionData {
            snapshot.appendSections([section])
            snapshot.appendItems(section.rowsModels, toSection: section)
        }
        collectionDataSource.apply(snapshot, animatingDifferences: false)
    }

    private func setupSize() {
        viewModel.setPreferredContentSize(
            size: CGSize(
                width: collectionView.contentSize.width,
                height: collectionView.contentSize.height + grid.space8.double()
            )
        )
    }
}

// MARK: - UICollectionViewDelegate

extension SelectableListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didTapCell(indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewModel.didTapCell(indexPath: indexPath)
    }
}

// MARK: - ItemsListView

extension SelectableListView: IntrinsicCollectionViewDelegate {
    func didChangeContentSize() {
        setupSize()
    }
}

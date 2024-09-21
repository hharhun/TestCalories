import Extensions
import UIKit

public typealias CollectionDataSource = UICollectionViewDiffableDataSource<CollectionSection, CollectionRow>

public typealias CollectionSnapshot = NSDiffableDataSourceSnapshot<CollectionSection, CollectionRow>

// MARK: - CollectionSection

public struct CollectionSection: Hashable {
    public var id: String
    public var type: String?
    public let headerModel: (any ConfigurableCollectionViewSectionModel)?
    public var rowsModels: [CollectionRow]
    public let footerModel: (any ConfigurableCollectionViewSectionModel)?

    public init(
        id: String? = nil,
        type: String? = nil,
        header: (any ConfigurableCollectionViewSectionModel)? = nil,
        rows: [CollectionRow],
        footer: (any ConfigurableCollectionViewSectionModel)? = nil
    ) {
        headerModel = header
        rowsModels = rows
        footerModel = footer

        self.type = type
        self.id = id ?? ((headerModel?.id ?? "") + (footerModel?.id ?? ""))
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    public func model(kind: String) -> (any ConfigurableCollectionViewSectionModel)? {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return headerModel

        case UICollectionView.elementKindSectionFooter:
            return footerModel

        default:
            return nil
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(headerModel?.hashValue)
        hasher.combine(headerModel?.id)
        hasher.combine(footerModel?.hashValue)
        hasher.combine(footerModel?.id)
        hasher.combine(id)
        hasher.combine(type)
    }
}

// MARK: - CollectionRow

public struct CollectionRow: Hashable {
    public var id: String { model.id }

    public let model: any ConfigurableCollectionViewCellModel

    public init(model: any ConfigurableCollectionViewCellModel) {
        self.model = model
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(model.hashValue)
        hasher.combine(model.hashValue)
    }
}

// MARK: - ConfigurableCollectionViewSectionModel

public protocol ConfigurableCollectionViewSectionModel: Hashable, Sendable {
    var viewSectionType: String { get }

    var id: String { get }
}

// MARK: - ConfigurableCollectionViewSectionModel

public extension ConfigurableCollectionViewSectionModel {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    func configure(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let itemCell = NSClassFromString(viewSectionType) as? UICollectionViewCell.Type
        else {
            return UICollectionViewCell()
        }

        let cell = collectionView.dequeue(cell: itemCell, for: indexPath)
        if let item = cell as? UnsafeConfigurable {
            item.make(with: self)
        }

        return cell
    }

    func configure(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        kind: String
    ) -> UICollectionReusableView {
        guard
            let itemCell = NSClassFromString(viewSectionType) as? UICollectionReusableView.Type
        else {
            return UICollectionReusableView()
        }

        let cell = collectionView.dequeue(supplementaryView: itemCell, kind: kind, for: indexPath)
        if let item = cell as? UnsafeConfigurable {
            item.make(with: self)
        }

        return cell
    }
}

// MARK: - ConfigurableCollectionViewCellModel

public protocol ConfigurableCollectionViewCellModel: Hashable {
    var viewCellType: String { get }

    var id: String { get }
}

public extension ConfigurableCollectionViewCellModel {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    func configure(collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        guard let itemCell = NSClassFromString(viewCellType) as? UICollectionViewCell.Type
        else {
            return UICollectionViewCell()
        }

        let cell = collectionView.dequeue(cell: itemCell, for: indexPath)

        if let item = cell as? UnsafeConfigurable {
            item.make(with: self)
        }

        if let item = self as? SelectedViewCellModel, item.isSelected {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        }

        return cell
    }
}

// MARK: - Array

public extension Array where Element == CollectionSection {
    func onceSelectRow(_ indexPath: IndexPath) -> [CollectionSection] {
        enumerated().compactMap { itemSection in
            var section = itemSection.element
            let rows = section.rowsModels.enumerated().compactMap { itemRow in
                var row = itemRow.element.model

                if var selectedRow = row as? (any SelectedViewCellModel & ConfigurableCollectionViewCellModel) {
                    selectedRow.isSelected = itemRow.offset == indexPath.row
                    row = selectedRow
                }

                return CollectionRow(model: row)
            }
            section.rowsModels = rows
            return section
        }
    }
}

import Constants
import Foundation
import UIKit

extension NSCollectionLayoutSection: GridConstantsInterface {
    enum Constants {
        static var space100: CGFloat { 100 }
    }

    public static func verticalList() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Constants.space100)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Constants.space100)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.boundarySupplementaryItems = []
        section.contentInsets = .zero

        return section
    }

    public static func verticalListSection(
        layoutEnvironment: NSCollectionLayoutEnvironment,
        appearance: UICollectionLayoutListConfiguration.Appearance = .insetGrouped,
        showsSeparators: Bool = true,
        headerMode: UICollectionLayoutListConfiguration.HeaderMode = .supplementary,
        footerMode: UICollectionLayoutListConfiguration.FooterMode = .none
    ) -> NSCollectionLayoutSection {
        var configuration = UICollectionLayoutListConfiguration(appearance: appearance)
        configuration.backgroundColor = .clear
        configuration.headerMode = headerMode
        configuration.footerMode = footerMode
        configuration.showsSeparators = showsSeparators
        let layoutSection = NSCollectionLayoutSection.list(
            using: configuration,
            layoutEnvironment: layoutEnvironment
        )

        return layoutSection
    }
}

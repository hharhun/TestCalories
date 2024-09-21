import Foundation
import UIComponents

class EmptyHeaderView: UICollectionViewCell {}

// MARK: - Configurable

extension EmptyHeaderView: ConfigurableView {
    func configure(with viewModel: EmptyHeaderViewModel) {}
}

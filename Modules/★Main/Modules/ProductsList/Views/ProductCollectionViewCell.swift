import Constants
import Core
import Resources
import UIComponents
import UIKit

// MARK: - Constants

private extension GridConstants {}

private extension DataConstants {
    var dashesLabel: String { "-" }
}

private extension AppearanceConstants {
    var backgroundColor: UIColor? { Resources.colors.cFFF9F5() }

    var titleLabelFont: UIFont? { Resources.font(type: .bold, size: 20) }
    var titleLabelColor: UIColor? { Resources.colors.c2A2A2A() }

    var descriptionLabelFont: UIFont? { Resources.font(type: .regular, size: 14) }
    var descriptionLabelColor: UIColor? { Resources.colors.c645F5A() }
}

// MARK: - ProductCollectionViewCell

class ProductCollectionViewCell: BaseCollectionViewCell {
    private var viewModel: ProductCollectionViewModel!

    private lazy var backgroundContainerView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = grid.space16
        $0.backgroundColor = appearance.backgroundColor
    }

    private lazy var mainStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = grid.space2
    }

    private lazy var titleLabel = UILabel().then {
        $0.font = appearance.titleLabelFont
        $0.textColor = appearance.titleLabelColor
    }

    private lazy var descriptionLabel = UILabel().then {
        $0.font = appearance.descriptionLabelFont
        $0.textColor = appearance.descriptionLabelColor
        $0.numberOfLines = .zero
    }

    private var spaceView = UIView()

    override func setupUI() {
        addSubviews([backgroundContainerView])

        backgroundContainerView.addSubviews([mainStackView])

        mainStackView.addArrangedSubviews([titleLabel, descriptionLabel])
    }

    override func setupConstraints() {
        backgroundContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(grid.space4)
        }

        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(grid.space16)
        }
    }
}

// MARK: - Configurable

extension ProductCollectionViewCell: ConfigurableView {
    func configure(with viewModel: ProductCollectionViewModel) {
        self.viewModel = viewModel

        titleLabel.text = viewModel.title

        descriptionLabel.text = viewModel.description
        descriptionLabel.isHidden = viewModel.description == nil
    }
}

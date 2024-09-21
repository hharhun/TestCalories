import Constants
import Core
import Resources
import UIComponents
import UIKit

// MARK: - Constants

private extension GridConstants {}

private extension DataConstants {
    var checkIcon: UIImage? { Resources.images.check() }
}

private extension AppearanceConstants {
    var backgroundColor: UIColor? { Resources.colors.cFFFAF7() }

    var titleLabelFont: UIFont? { Resources.font(type: .regular, size: 16) }
    var titleLabelColor: UIColor? { Resources.colors.c351F0E() }
}

// MARK: - SelectableListCollectionViewCell

class SelectableListCollectionViewCell: BaseCollectionViewCell {
    private var viewModel: SelectableListCollectionViewModel!

    private lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = grid.space10
    }

    private lazy var titleLabel = UILabel().then {
        $0.font = appearance.titleLabelFont
        $0.textColor = appearance.titleLabelColor
        $0.numberOfLines = .zero
    }

    private lazy var selectedView = UIImageView().then {
        $0.image = data.checkIcon
        $0.contentMode = .scaleAspectFit
    }

    private lazy var divideView = UIView().then {
        $0.backgroundColor = .lightGray
    }

    override var isSelected: Bool {
        didSet {
            setupSelection()
        }
    }

    override func setupUI() {
        backgroundColor = appearance.backgroundColor

        addSubviews([stackView, divideView])
        stackView.addArrangedSubviews([titleLabel, selectedView])

        backgroundColor = .clear
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(grid.space12)
            $0.top.bottom.equalToSuperview().inset(grid.space8)
        }

        selectedView.snp.makeConstraints {
            $0.width.equalTo(grid.space20)
        }
        divideView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(grid.space12)
            $0.height.equalTo(grid.space1.half())
            $0.bottom.equalToSuperview()
        }
    }

    private func setupSelection() {
        selectedView.alpha = !isSelected ? .zero : grid.space1
    }
}

// MARK: - Configurable

extension SelectableListCollectionViewCell: ConfigurableView {
    func configure(with viewModel: SelectableListCollectionViewModel) {
        self.viewModel = viewModel

        titleLabel.text = viewModel.title

        setupSelection()
    }
}

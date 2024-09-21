import Constants
import Extensions
import Foundation
import Resources
import SnapKit
import Then
import UIKit

// MARK: - Constants

private extension GridConstants {}

private extension DataConstants {
    var arrowIcon: UIImage? { Resources.images.arrow() }
}

private extension AppearanceConstants {
    var titleLabelFont: UIFont? { Resources.font(type: .regular, size: 16) }

    var backgroundColor: UIColor? { Resources.colors.cFFF9F5() }
    var fontColor: UIColor? { Resources.colors.c351F0E() }

    var selectedColor: UIColor? { Resources.colors.cFFFFFF() }
    var selectedBackgroundColor: UIColor? { Resources.colors.cAF927C() }

    var moveArrowDuration: TimeInterval { 0.3 }

    var clearIcon: UIImage? { Resources.images.clearSelectable() }
}

// MARK: - SelectableButtonDelegate

protocol SelectableButtonDelegate: AnyObject {
    func didTapSelectableButton(_ button: SelectableButton)
    func didTapClearSelectableButton(_ button: SelectableButton)
}

// MARK: - SelectableButton

final class SelectableButton: UIView {
    enum SelectionState {
        case selected, selectedProcess, unSelected
    }

    var selectionState: SelectionState {
        didSet {
            updateSelected()
        }
    }

    let id: String

    weak var delegate: SelectableButtonDelegate?

    lazy var titleLabel = UILabel().then {
        $0.font = appearance.titleLabelFont
    }

    private lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = grid.space10
    }

    private lazy var arrowImageView = UIImageView().then {
        $0.image = data.arrowIcon
        $0.contentMode = .scaleAspectFit
    }

    private lazy var clearButton = UIButton().then {
        $0.setImage(appearance.clearIcon, for: .normal)
        $0.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
    }

    init(id: String) {
        selectionState = .unSelected
        self.id = id

        super.init(frame: .zero)

        setupUI()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        clipsToBounds = true
        layer.cornerRadius = grid.space16

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(grid.space12)
            $0.top.bottom.equalToSuperview().inset(grid.space4)
        }

        stackView.addArrangedSubviews(
            [
                titleLabel,
                arrowImageView,
                clearButton
            ]
        )
        clearButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: grid.space24, height: grid.space24))
        }
        arrowImageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: grid.space24, height: grid.space24))
        }

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))

        updateSelected()
    }

    private func updateSelected() {
        switch selectionState {
        case .selected:
            arrowImageView.isHidden = true
            clearButton.isHidden = !arrowImageView.isHidden
            backgroundColor = appearance.selectedBackgroundColor
            titleLabel.textColor = appearance.selectedColor

        case .selectedProcess:
            arrowImageView.isHidden = false
            UIView.animate(withDuration: appearance.moveArrowDuration) {
                self.arrowImageView.transform = CGAffineTransform(rotationAngle: .pi)
            }
            clearButton.isHidden = !arrowImageView.isHidden
            backgroundColor = appearance.backgroundColor
            titleLabel.textColor = appearance.fontColor

        case .unSelected:
            arrowImageView.isHidden = false
            UIView.animate(withDuration: appearance.moveArrowDuration) {
                self.arrowImageView.transform = .identity
            }
            clearButton.isHidden = !arrowImageView.isHidden
            backgroundColor = appearance.backgroundColor
            titleLabel.textColor = appearance.fontColor
        }
    }

    @objc
    private func viewTapped() {
        delegate?.didTapSelectableButton(self)
    }

    @objc
    private func clearTapped() {
        delegate?.didTapClearSelectableButton(self)
    }
}

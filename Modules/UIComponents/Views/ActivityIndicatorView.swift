import Constants
import Extensions
import Foundation
import NVActivityIndicatorView
import Resources
import SnapKit

// MARK: - ActivityIndicatorView

public class ActivityIndicatorView: UIView {
    private lazy var activityIndicatorView: UIView = NVActivityIndicatorView(
        frame: .zero,
        type: .ballScaleMultiple,
        color: Resources.colors.c351F0E()
    ).then {
        $0.startAnimating()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

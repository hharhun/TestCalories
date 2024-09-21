import Foundation
import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
    override public init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    private func commonInit() {
        setup()
        setupUI()
        setupConstraints()
    }

    open func setup() {}

    open func setupUI() {}

    open func setupConstraints() {}
}

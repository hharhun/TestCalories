import Foundation
import UIKit

open class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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

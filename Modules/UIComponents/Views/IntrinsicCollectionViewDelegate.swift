import UIKit

// MARK: - IntrinsicCollectionViewDelegate

public protocol IntrinsicCollectionViewDelegate: AnyObject {
    func didChangeContentSize()
}

// MARK: - IntrinsicCollectionView

public class IntrinsicCollectionView: UICollectionView {
    public weak var intrinsicDelegate: IntrinsicCollectionViewDelegate?

    override public var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override public var intrinsicContentSize: CGSize {
        CGSize(width: max(contentSize.width, 40), height: max(contentSize.height, 40))
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        intrinsicDelegate?.didChangeContentSize()
    }
}

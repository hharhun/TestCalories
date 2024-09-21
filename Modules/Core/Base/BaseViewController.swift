import Constants
import Core
import Extensions
import Resources
import SnapKit
import UIComponents
import UIKit

// MARK: - Constants

private extension GridConstants {}

private extension DataConstants {}

private extension AppearanceConstants {}

// MARK: - BaseViewControllerInterface

public protocol BaseViewControllerInterface: ViewControllerInterface, BaseViewControllerProtocol {}

// MARK: - BaseViewControllerProtocol

public protocol BaseViewControllerProtocol {
    func showHud()
    func hideHud()
}

// MARK: - BaseViewController

open class BaseViewController<View, ViewModel>: UIViewController {
    public var contentView: View!
    public var viewModel: ViewModel!

    public lazy var activityIndicatorView: UIView = ActivityIndicatorView(frame: .zero).then {
        $0.snp.makeConstraints {
            $0.size.equalTo(grid.space48)
        }
    }

    public init(contentView: View!, viewModel: ViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.contentView = contentView
        self.viewModel = viewModel

        commonInit()
    }

    public required init() {
        super.init(nibName: nil, bundle: nil)

        commonInit()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        (contentView as? BaseViewProtocol)?.viewLoaded()
        (viewModel as? BaseViewModelProtocol)?.viewLoaded()

        setup()
        setupUI()
        setupConstraints()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        (contentView as? BaseViewProtocol)?.viewWillAppear()
        (viewModel as? BaseViewModelProtocol)?.viewAppeared()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        (contentView as? BaseViewProtocol)?.viewWillDisappear()
    }

    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        switch UIApplication.shared.applicationState {
        case .background, .inactive:
            return
        @unknown default:
            super.viewWillTransition(to: size, with: coordinator)
        }
    }

    open func updateLayoutAnimated(animations: (() -> Void)? = nil, complection: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                animations?()
                self.view.layoutIfNeeded()
            },
            completion: { _ in complection?() }
        )
    }

    open func commonInit() {}

    open func addHideKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    open func setup() {
        (contentView as? BaseViewProtocol)?.setup()
    }

    open func setupUI() {
        (contentView as? BaseViewProtocol)?.setupUI()
    }

    open func setupConstraints() {
        (contentView as? BaseViewProtocol)?.setupConstraints()
    }

    public func pinContentViewFull(toSafeArea: Bool = true) {
        guard let contentView = contentView as? UIView else { return }
        contentView.frame = view.frame
        view.addSubview(contentView)
        view.sendSubviewToBack(contentView)

        contentView.snp.makeConstraints {
            $0.edges.equalTo(toSafeArea ? view.safeAreaLayoutGuide : view)
        }
    }

    // MARK: - Actions

    @objc
    open func hideKeyboard() {
        view.endEditing(true)
    }

    open func showError(title: String, message: String) {
        alert(title, message: message)
    }

    // MARK: -

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - BaseViewControllerProtocol

extension BaseViewController: BaseViewControllerProtocol {
    open func showHud() {
        guard activityIndicatorView.superview == nil else { return }

        view.addSubview(activityIndicatorView)

        activityIndicatorView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    open func hideHud() {
        activityIndicatorView.removeFromSuperview()
    }
}

// MARK: - BaseViewControllerInterface

extension BaseViewController: BaseViewControllerInterface {}

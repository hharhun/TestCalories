import Constants
import Core
import Typist
import UIKit

// MARK: - Constants

private extension GridConstants {}

private extension DataConstants {}

private extension AppearanceConstants {}

// MARK: - BaseViewInterface

public protocol BaseViewInterface: ViewInterface {}

// MARK: - BaseViewProtocol

protocol BaseViewProtocol {
    func viewWillAppear()
    func viewWillDisappear()
    func viewLoaded()
    func setup()
    func setupUI()
    func setupConstraints()
}

// MARK: - BaseViewController

open class BaseView<ViewModel>: UIView {
    public enum KeyboardState {
        case willShow(frame: CGRect)
        case didShow(frame: CGRect)
        case willHide
        case didHide
    }

    public var viewModel: ViewModel!

    public let keyboard = Typist()

    open func viewWillAppear() {
        startKeyboardObserving()
    }

    open func viewWillDisappear() {
        stopKeyboardObserving()
    }

    open func viewLoaded() {}

    open func setup() {}

    open func setupUI() {}

    open func setupConstraints() {}

    // MARK: - Keyboard

    open func startKeyboardObserving() {
        keyboard
            .on(event: .willShow) { [weak self] options in
                self?.keyboardDidChangeState(.willShow(frame: options.endFrame))
                self?.updateLayoutAnimated()
            }
            .on(event: .didShow) { [weak self] options in
                self?.keyboardDidChangeState(.didShow(frame: options.endFrame))
                self?.updateLayoutAnimated()
            }
            .on(event: .willHide) { [weak self] _ in
                self?.keyboardDidChangeState(.willHide)
                self?.updateLayoutAnimated()
            }
            .on(event: .didHide) { [weak self] _ in
                self?.keyboardDidChangeState(.didHide)
                self?.updateLayoutAnimated()
            }
            .start()
    }

    open func stopKeyboardObserving() {
        keyboard.stop()
    }

    open func keyboardDidChangeState(_ state: KeyboardState) {}

    open func updateLayoutAnimated(animations: (() -> Void)? = nil, complection: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                animations?()
                self.layoutIfNeeded()
            },
            completion: { _ in complection?() }
        )
    }
}

// MARK: - BaseViewInterface

extension BaseView: BaseViewInterface {}

// MARK: - BaseViewProtocol

extension BaseView: BaseViewProtocol {}

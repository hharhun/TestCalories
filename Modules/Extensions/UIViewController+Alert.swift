import Resources
import UIKit

// MARK: - DataConstants

private enum DataConstants {
    static var okText: String? { Resources.strings.commonOk() }
    static var cancelText: String? { Resources.strings.commonCancel() }
}

// MARK: - UIViewController

extension UIViewController {
    static var topMostController: UIViewController? {
        var topMostController = UIApplication.shared.windows.first?.rootViewController
        while topMostController?.presentedViewController != nil {
            topMostController = topMostController?.presentedViewController
        }

        return topMostController
    }
}

// MARK: - UIViewController

public extension UIViewController {
    /// Title with message and 'Done' button
    func alert(_ text: String, dismissAfter: TimeInterval, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
                alert.dismiss(animated: true, completion: completion)
            }
        }
    }

    /// Title with message
    func alert(_ title: String?, message: String?) {
        alert(title, message: message, cancel: nil, buttons: [], completion: nil)
    }

    /// Title with message
    func alert(_ title: String?, message: String?, buttons: [String]) {
        alert(title, message: message, cancel: nil, buttons: buttons, completion: nil)
    }

    /// Title with message, 'Done' button and completion block
    func alert(_ title: String?, message: String?, completion: (() -> Void)?) {
        alert(title, message: message, cancel: nil, buttons: [], completion: { _, _ in
            if completion != nil {
                DispatchQueue.main.async {
                    completion?()
                }
            }
        })
    }

    /// Title with message and button title
    func alert(_ title: String?, message: String?, cancel: String?) {
        alert(title, message: message, cancel: cancel, buttons: [], completion: nil)
    }

    /// Title with message, cancel button title and completion block
    func alert(_ title: String?, message: String?, cancel: String?, completion: (() -> Void)?) {
        alert(title, message: message, cancel: cancel, buttons: [], completion: { _, _ in
            if completion != nil {
                DispatchQueue.main.async {
                    completion?()
                }
            }
        })
    }

    /// Title with message, cancel button title, others buttons titles array and completion block
    func alertA(
        _ title: String?,
        message: NSAttributedString?,
        cancel: String?,
        buttons: [String],
        completion: ((UIAlertAction) -> Void)?
    ) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        var cancelTitle: String = DataConstants.okText.orEmpty
        if let cancel = cancel {
            cancelTitle = cancel
        }
        let action = UIAlertAction(title: cancelTitle, style: .cancel, handler: { alertAction in
            if completion != nil {
                DispatchQueue.main.async {
                    completion?(alertAction)
                }
            }
        })
        alert.addAction(action)

        for buttonTitle in buttons {
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { alertAction in
                if completion != nil {
                    DispatchQueue.main.async {
                        completion?(alertAction)
                    }
                }
            })
            alert.addAction(action)
        }

        alert.setValue(message, forKey: "attributedMessage")

        present(alert, animated: true, completion: nil)
    }

    /// Title with message, cancel button title, others buttons titles array and completion block
    func alert(
        _ title: String?,
        message: String?,
        cancel: String?,
        buttons: [String] = [],
        completion: ((_ index: Int, _ title: String) -> Void)?
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var cancelTitle: String = DataConstants.okText.orEmpty
        if let cancel = cancel {
            cancelTitle = cancel
        }
        let action = UIAlertAction(title: cancelTitle, style: .cancel, handler: { _ in
            if completion != nil {
                DispatchQueue.main.async {
                    completion?(-1, cancelTitle)
                }
            }
        })

        if buttons.isEmpty {
            alert.addAction(action)
        }

        for button in buttons.enumerated() {
            let action = UIAlertAction(title: button.element, style: .default, handler: { _ in
                if completion != nil {
                    DispatchQueue.main.async {
                        completion?(button.offset, button.element)
                    }
                }
            })
            alert.addAction(action)
        }

        present(alert, animated: true, completion: nil)
    }

    /// Title with message, cancel button title, others buttons titles array and completion block
    func actionSheet(
        _ title: String?,
        message: String?,
        cancel: String?,
        buttons: [String] = [],
        sourceRect: CGRect? = nil,
        sourceView: UIView? = nil,
        barButton: UIBarButtonItem? = nil,
        completion: ((_ index: Int, _ title: String) -> Void)?
    ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        var cancelTitle: String = DataConstants.cancelText.orEmpty
        if let cancel = cancel {
            cancelTitle = cancel
        }
        let action = UIAlertAction(title: cancelTitle, style: .cancel, handler: { _ in })
        alert.addAction(action)

        for (buttonIndex, buttonTitle) in buttons.enumerated() {
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
                if completion != nil {
                    DispatchQueue.main.async {
                        completion?(buttonIndex, buttonTitle)
                    }
                }
            })
            alert.addAction(action)
        }

        let presenter: UIViewController? = (navigationController != nil) ? navigationController : self
        presenter?.present(alert, animated: true, completion: nil)
        return alert
    }

    /// Title with message, cancel button title, others buttons titles array and completion block
    func alert(
        _ title: String?,
        message: String?,
        reloadTitle: String,
        reload: @escaping () -> Void
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )

        alertController.addAction(
            UIAlertAction(title: reloadTitle, style: UIAlertAction.Style.default) { _ in
                DispatchQueue.main.async {
                    reload()
                }
            }
        )

        let presenter: UIViewController? = (navigationController != nil) ? navigationController : self
        presenter?.present(alertController, animated: true, completion: nil)
    }
}

import Core
import Extensions
import Models

// MARK: - BaseViewModelInterface

public protocol BaseViewModelInterface: ViewModelInterface, BaseViewModelProtocol {}

// MARK: - BaseViewProtocol

public protocol BaseViewModelProtocol {
    func viewLoaded()
    func viewAppeared()
}

// MARK: - BaseViewModel

open class BaseViewModel<ViewController, View, ConfigModel> {
    private weak var storageController: AnyObject?
    public var controller: ViewController! {
        get {
            storageController.map { $0 as! ViewController }
        }
        set {
            storageController = newValue as? AnyObject
        }
    }

    private weak var storageView: AnyObject?
    public var view: View! {
        get {
            storageView.map { $0 as! View }
        }
        set {
            storageView = newValue as? AnyObject
        }
    }

    public let config: ConfigModel

    public var loadingStatus: LoadingStatus = .ended
    public var loadingProcess: LoadingProcess {
        { [weak self] status in
            self?.loadingStatus = status

            switch status {
            case .inProcess:
                (self?.controller as? BaseViewControllerProtocol)?.showHud()

            case .ended:
                (self?.controller as? BaseViewControllerProtocol)?.hideHud()
            }
        }
    }

    public var uuid = UUID()

    public required init(config: ConfigModel) {
        self.config = config
    }

    @objc
    open dynamic func viewLoaded() {}

    @objc
    open dynamic func viewAppeared() {}
}

// MARK: - BaseViewModelProtocol

extension BaseViewModel: BaseViewModelProtocol {}

// MARK: - BaseViewModelInterface

extension BaseViewModel: BaseViewModelInterface {}

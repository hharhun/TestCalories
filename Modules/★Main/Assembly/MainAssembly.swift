import Core
import Models
import UIComponents
import UseCases

// MARK: - MainAssembly

protocol MainAssembly: BaseAssembly {
    func makeProductsList(
        output: ProductsListOutputInterface?
    ) -> (vc: ProductsListViewController, input: ProductsListInputInterface)
    func makeSelectableList(
        output: SelectableListOutputInterface?,
        id: String,
        list: [String],
        selectedList: [String],
        rect: CGRect,
        sourceView: UIView
    ) -> SelectableListViewController
}

// MARK: - MainAssemblyImpl

public final class MainAssemblyImpl: NSObject, MainAssembly {
    private let window: UIWindow

    private let useCasesAssembly: UseCasesAssembly

    let rootAssembly: RootAssembly

    public init(
        rootAssembly: RootAssembly,
        useCasesAssembly: UseCasesAssembly,
        window: UIWindow
    ) {
        self.window = window

        self.rootAssembly = rootAssembly
        self.useCasesAssembly = useCasesAssembly
    }

    @available(*, unavailable)
    override required init() {
        fatalError("init() has not been implemented")
    }

    public func coordinator(navigation: UINavigationController?) -> BaseCoordinator {
        MainCoordinator(assembly: self, navigation: navigation)
    }

    public func coordinator() -> BaseCoordinator {
        MainCoordinator(assembly: self, navigation: rootAssembly.makeMainNavigation())
    }
}

// MARK: -

extension MainAssemblyImpl {
    func makeProductsList(
        output: ProductsListOutputInterface?
    ) -> (vc: ProductsListViewController, input: ProductsListInputInterface) {
        let assembly = ProductsListSceneAssembly(
            config: ProductsListConfigModel(
                output: output,
                foodsUseCase: useCasesAssembly.foodsUseCase
            )
        )
        return (
            vc: assembly.controller as! ProductsListViewController,
            input: assembly.viewModel as! ProductsListInputInterface
        )
    }

    func makeSelectableList(
        output: SelectableListOutputInterface?,
        id: String,
        list: [String],
        selectedList: [String],
        rect: CGRect,
        sourceView: UIView
    ) -> SelectableListViewController {
        let assembly = SelectableListSceneAssembly(
            config: SelectableListConfigModel(
                output: output,
                id: id,
                list: list,
                selectedList: selectedList
            )
        )

        guard let vc = assembly.controller else { return .init() }

        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.sourceRect = rect
        vc.popoverPresentationController?.sourceView = sourceView
        vc.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        vc.popoverPresentationController?.canOverlapSourceViewRect = false

        return vc as! SelectableListViewController
    }
}

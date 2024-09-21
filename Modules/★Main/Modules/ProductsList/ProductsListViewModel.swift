import Core
import Models
import Resources
import UIComponents
import UseCases

// MARK: - Constants

private enum Constants {
    static var delay: TimeInterval { 0.5 }
}

// MARK: - ProductsListViewModelInterface

protocol ProductsListViewModelInterface: BaseViewModelInterface {
    var collectionData: [CollectionSection] { get }

    func didTapCell(indexPath: IndexPath)
    func search(with searchText: String)

    func needLoadMore()

    func select(
        type: ProductsListViewModel.SelectableType,
        rect: CGRect,
        sourceView: UIView
    )
    func clear(type: ProductsListViewModel.SelectableType)
}

// MARK: - ProductsListViewController

final class ProductsListViewModel: BaseViewModel<
    ProductsListViewController,
    ProductsListViewInterface,
    ProductsListConfigModel
> {
    enum SelectableType: String, CaseIterable {
        case brand, category
    }

    private let throttler = CallDebouncer(delay: Constants.delay)

    var collectionData: [CollectionSection] = []

    private var foods: [Food] = []

    private var currentPage: Int = .zero
    private var searchText = ""

    private var categories = Categories.allCases
    private var brands = Brands.allCases

    private var selectedBrands = [Brands]()
    private var selectedCategories = [Categories]()

    private var totalPages = Int.zero

    private var searchCriteria: SearchCriteria?

    private var needToLoad: Bool {
        guard let criteria = searchCriteria else { return true }

        let brandName = criteria.brandName.orEmpty
        let foodCategory = criteria.foodCategory.orEmpty
        let query = criteria.query.orEmpty

        return
            !(
                criteria.pageNumber == currentPage + 1 &&
                    brandName == selectedBrands.compactMap { $0.rawValue }.joined(separator: ",") &&
                    foodCategory == selectedCategories.compactMap { $0.rawValue }.joined(separator: ",") &&
                    query == searchText
            )
    }

    override func viewLoaded() {
        super.viewLoaded()

        loadData()
    }

    private func loadData() {
        guard loadingStatus == .ended && needToLoad else { return }

        config.foodsUseCase.loadFoods(
            searchText: searchText,
            page: currentPage + 1,
            foodCategory: selectedCategories.compactMap { $0.rawValue }.joined(separator: ","),
            brandName: selectedBrands.compactMap { $0.rawValue }.joined(separator: ","),
            loading: loadingProcess
        ) { [weak self] result in
            guard let self else { return }

            switch result {
            case .value(let criteria, let foods, let totalPages):
                defer {
                    self.totalPages = totalPages
                    self.searchCriteria = criteria
                    setupData()
                }

                guard self.currentPage == .zero else {
                    self.foods.append(contentsOf: foods)

                    return
                }
                self.foods = foods

            case .error(let error):
                self.controller.showError(title: Resources.strings.commonError(), message: error.message.orEmpty)
            }
        }
    }

    private func setupData() {
        collectionData = [
            CollectionSection(
                rows: foods.compactMap {
                    CollectionRow(model: ProductCollectionViewModel(food: $0))
                }
            )
        ]
        view.reloadData()
    }
}

// MARK: - ProductsListViewModelInterface

extension ProductsListViewModel: ProductsListViewModelInterface {
    func needLoadMore() {
        guard currentPage < totalPages else { return }
        currentPage += 1
        loadData()
    }

    func didTapCell(indexPath: IndexPath) {}

    func search(with searchText: String) {
        throttler.flush()
        throttler.throttle { [weak self] in
            DispatchQueue.main.async {
                self?.searchText = searchText
                self?.currentPage = .zero
                self?.loadData()
            }
        }
    }

    func select(
        type: ProductsListViewModel.SelectableType,
        rect: CGRect,
        sourceView: UIView
    ) {
        var list = [String]()
        var selectedList = [String]()

        switch type {
        case .brand:
            list = brands.compactMap { $0.rawValue }
            selectedList = selectedBrands.compactMap { $0.rawValue }

        case .category:
            list = categories.compactMap { $0.rawValue }
            selectedList = selectedCategories.compactMap { $0.rawValue }
        }

        guard !list.isEmpty else {
            controller.showError(title: Resources.strings.productsListListIsEmpty(), message: "")
            return
        }
        config.output?.showSelectableList(
            id: type.rawValue,
            list: list,
            selectedList: selectedList,
            rect: rect,
            sourceView: sourceView
        )
        updateState(type: type, isHiddenView: false)
    }

    func clear(type: ProductsListViewModel.SelectableType) {
        switch type {
        case .brand:
            selectedBrands = []

        case .category:
            selectedCategories = []
        }

        currentPage = .zero
        updateState(type: nil, isHiddenView: true)
        loadData()
    }
}

// MARK: - ProductsListInputInterface

extension ProductsListViewModel: ProductsListInputInterface {
    func didUpdatedSelectedItems(id: String, items: [String]) {
        guard let type = SelectableType(rawValue: id) else { return }
        switch type {
        case .brand:
            selectedBrands = items.compactMap { Brands(rawValue: $0) }

        case .category:
            selectedCategories = items.compactMap { Categories(rawValue: $0) }
        }

        updateState(type: type, isHiddenView: false)
    }

    func didHideSelectableView() {
        updateState(type: nil, isHiddenView: true)

        throttler.flush()
        throttler.throttle { [weak self] in
            DispatchQueue.main.async {
                self?.currentPage = .zero
                self?.loadData()
            }
        }
    }

    func updateState(type: SelectableType?, isHiddenView: Bool) {
        var state: SelectableButton.SelectionState = isHiddenView ? .unSelected : .selectedProcess
        if type == .brand || type == nil {
            view.setupSelectionState(type: .brand, state: selectedBrands.isEmpty ? state : .selected)
        }
        if type == .category || type == nil {
            view.setupSelectionState(type: .category, state: selectedCategories.isEmpty ? state : .selected)
        }
    }
}

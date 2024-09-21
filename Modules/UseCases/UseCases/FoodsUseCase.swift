import Core
import Models
import Resources

// MARK: - FoodsUseCase

public protocol FoodsUseCase {
    func loadFoods(
        searchText: String,
        page: Int,
        foodCategory: String,
        brandName: String,
        loading: LoadingProcess?,
        completion: @escaping UICompletionResult<(SearchCriteria?, [Food], Int)>
    )
}

// MARK: - FoodsUseCaseImpl

class FoodsUseCaseImpl: BaseUseCase, FoodsUseCase {
    private let foodsRequestService: FoodsRequestService

    // MARK: Public

    init(
        unsecure: UnsecurePropertiesService,
        foodsRequestService: FoodsRequestService
    ) {
        self.foodsRequestService = foodsRequestService

        super.init(unsecure: unsecure)
    }

    func loadFoods(
        searchText: String,
        page: Int,
        foodCategory: String,
        brandName: String,
        loading: LoadingProcess?,
        completion: @escaping UICompletionResult<(SearchCriteria?, [Food], Int)>
    ) {
        loading?(.inProcess)
        foodsRequestService.search(
            searchText: searchText,
            page: page,
            foodCategory: foodCategory,
            brandName: brandName
        ) { [weak self] result in
            guard let self else { return }
            loading?(.ended)

            switch result {
            case .value(var response):
                completion(.value((response?.searchCriteria, response?.foods ?? [], response?.totalPages ?? .zero)))

            case .error(let error):
                completion(.error(self.serverError(error)))
            }
        }
    }
}

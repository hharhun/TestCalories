import Constants
import Foundation
import Models

// MARK: - FoodsRequestService

protocol FoodsRequestService {
    func search(
        searchText: String,
        page: Int,
        foodCategory: String,
        brandName: String,
        completion: @escaping Completion<FoodResponse?>
    )
}

// MARK: - FoodsRequestServiceImpl

class FoodsRequestServiceImpl: BaseRequestService, FoodsRequestService {
    func search(
        searchText: String,
        page: Int,
        foodCategory: String,
        brandName: String,
        completion: @escaping Completion<FoodResponse?>
    ) {
        exec(
            path: .searchFoods,
            parameters: [
                "query": searchText.isEmpty ? nil : searchText,
                "pageNumber": page,
                "foodCategory": foodCategory.isEmpty ? nil : foodCategory,
                "brandOwner": brandName.isEmpty ? nil : brandName
            ],
            method: .get,
            completion: completion
        )
    }
}

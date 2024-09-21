import Foundation
import Models

struct FoodResponse {
    let totalHits: Int?
    let currentPage: Int?
    let totalPages: Int?
    let pageList: [Int]?
    let searchCriteria: SearchCriteria?
    let foods: [Food]?
}

// MARK: - Parsing

extension FoodResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case totalHits, currentPage, totalPages
        case pageList
        case searchCriteria = "foodSearchCriteria"
        case foods
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let totalHits = try? container.decode(Int?.self, forKey: CodingKeys.totalHits)
        let currentPage = try? container.decode(Int?.self, forKey: CodingKeys.currentPage)
        let totalPages = try? container.decode(Int?.self, forKey: CodingKeys.totalPages)

        let pageList = try? container.decode([Int]?.self, forKey: CodingKeys.pageList)

        let foodSearchCriteria = try? container.decode(
            SearchCriteria?.self, forKey: CodingKeys.searchCriteria
        )

        let foods = try? container.decode([Food]?.self, forKey: CodingKeys.foods)

        self.init(
            totalHits: totalHits,
            currentPage: currentPage,
            totalPages: totalPages,
            pageList: pageList,
            searchCriteria: foodSearchCriteria,
            foods: foods
        )
    }

    func encode(to _: Encoder) throws {}
}

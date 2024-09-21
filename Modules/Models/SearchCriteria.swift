import Foundation

public struct SearchCriteria {
    public let query: String?
    public let pageNumber: Int?
    public let numberOfResultsPerPage: Int?
    public let pageSize: Int?
    public let foodCategory: String?
    public let brandName: String?

    public init(
        query: String?,
        pageNumber: Int?,
        numberOfResultsPerPage: Int?,
        pageSize: Int?,
        foodCategory: String?,
        brandName: String?
    ) {
        self.query = query
        self.pageNumber = pageNumber
        self.numberOfResultsPerPage = numberOfResultsPerPage
        self.pageSize = pageSize
        self.foodCategory = foodCategory
        self.brandName = brandName
    }
}

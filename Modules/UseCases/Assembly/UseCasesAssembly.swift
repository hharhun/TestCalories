import Core

// MARK: - UseCasesAssembly

public protocol UseCasesAssembly {
    var foodsUseCase: FoodsUseCase { get }
}

// MARK: - UseCasesAssemblyImpl

public class UseCasesAssemblyImpl: UseCasesAssembly {
    private let commonAssembly: CommonAssembly
    private let propertiesAssembly: PropertiesAssembly
    private let requestsAssembly: RequestsAssembly

    public lazy var foodsUseCase: FoodsUseCase = FoodsUseCaseImpl(
        unsecure: propertiesAssembly.unsecureService,
        foodsRequestService: requestsAssembly.foodsRequestService
    )

    public convenience init() {
        self.init(
            commonAssembly: CommonAssemblyImpl(),
            propertiesAssembly: PropertiesAssemblyImpl(),
            requestsAssembly: RequestsAssemblyImpl()
        )
    }

    init(
        commonAssembly: CommonAssembly,
        propertiesAssembly: PropertiesAssembly,
        requestsAssembly: RequestsAssembly
    ) {
        self.commonAssembly = commonAssembly
        self.propertiesAssembly = propertiesAssembly
        self.requestsAssembly = requestsAssembly
    }
}

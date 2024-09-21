import Core

// MARK: - RequestsAssembly

protocol RequestsAssembly {
    var foodsRequestService: FoodsRequestService { get }
}

// MARK: - RequestsAssemblyImpl

class RequestsAssemblyImpl: RequestsAssembly {
    private let propertiesAssembly: PropertiesAssembly
    private let commonAssembly: CommonAssembly

    lazy var foodsRequestService: FoodsRequestService = FoodsRequestServiceImpl(
        secure: propertiesAssembly.secureService,
        unsecure: propertiesAssembly.unsecureService
    )

    // MARK: - Init

    init(
        propertiesAssembly: PropertiesAssembly = PropertiesAssemblyImpl(),
        commonAssembly: CommonAssembly = CommonAssemblyImpl()
    ) {
        self.propertiesAssembly = propertiesAssembly
        self.commonAssembly = commonAssembly
    }

    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }
}

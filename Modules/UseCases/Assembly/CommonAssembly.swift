import Core

// MARK: - CommonAssembly

protocol CommonAssembly {
    var validator: Validator { get }
}

// MARK: - CommonAssemblyImpl

class CommonAssemblyImpl: CommonAssembly {
    lazy var validator: Validator = ValidatorImpl()
}

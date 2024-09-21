import Constants
import Core
import Foundation
import Models
import Moya
import Resources

// MARK: - BaseRequestService

//  swiftlint:disable all

class BaseRequestService {
    enum Path: String {
        case searchFoods = "foods/search"
    }

    private let request = RequestManager()

    let secureService: SecurePropertiesService?
    let unsecureService: UnsecurePropertiesService?

    init(
        secure: SecurePropertiesService? = nil,
        unsecure: UnsecurePropertiesService? = nil
    ) {
        secureService = secure
        unsecureService = unsecure
    }

    func exec<ResponseType: Codable>(
        baseURL: String = AppConstants.baseApiUrl,
        apiVersion: String? = AppConstants.apiVersion,
        path: Path,
        parameters: [String: Any]? = nil,
        body: [String: Any]? = nil,
        method: RequestMethod,
        completion: @escaping Completion<ResponseType>
    ) {
        exec(
            baseURL: baseURL,
            apiVersion: apiVersion,
            path: path.rawValue,
            parameters: parameters,
            body: body,
            method: method,
            completion: completion
        )
    }

    func exec<ResponseType: Codable>(
        baseURL: String = AppConstants.baseApiUrl,
        apiVersion: String? = nil,
        path: String,
        parameters: [String: Any]? = nil,
        multipartData: [MultipartFormData]? = nil,
        body: [String: Any]? = nil,
        method: RequestMethod,
        completion: @escaping Completion<ResponseType>
    ) {
        let urlStr = "\(baseURL)\(apiVersion == nil ? "" : "\(apiVersion.orEmpty)")"
        guard let url = URL(string: urlStr) else {
            completion(.error(UIError.wrongUrl))
            return
        }

        exec(
            baseURL: url,
            path: path,
            parameters: parameters,
            body: body,
            multipartData: multipartData,
            method: method
        ) { [weak self] in
            self?.exec(
                baseURL: baseURL,
                path: path,
                parameters: parameters,
                body: body,
                method: method,
                completion: completion
            )
        }
        completion: { (result: Result<ResponseType>) in
            switch result {
            case .value(let response):
                completion(.value(response))

            case .error(let error):
                completion(.error(error))
            }
        }
    }
}

// MARK: - Private

extension BaseRequestService {
    private func exec<ResponseType: Codable>(
        baseURL: URL,
        path: String,
        header: [String: String]? = nil,
        parameters: [String: Any]? = nil,
        body: [String: Any]? = [:],
        multipartData: [MultipartFormData]? = nil,
        method: RequestMethod,
        refresh: Action? = nil,
        completion: @escaping Completion<ResponseType>
    ) {
        let headers = composeHeader(path: path, header: header)

        var parameters: [String: Any] = parameters ?? [:]
        parameters["api_key"] = "\(AppConstants.apiKey)"

        request.exec(
            baseURL: baseURL,
            path: path,
            parameters: parameters,
            body: body,
            headers: headers,
            multipartData: multipartData,
            method: method,
            completion: { (result: Result<ResponseType>) in
                switch result {
                case .value(let response):
                    completion(.value(response))

                case .error(let error):
                    guard let uiError = error as? UIError else {
                        completion(.error(error))
                        return
                    }

                    completion(.error(error))
                }
            }
        )
    }

    private func composeHeader(path: String, header: [String: String]?) -> [String: String] {
        if let header = header { return header }
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        return headers
    }
}

//  swiftlint:enable all

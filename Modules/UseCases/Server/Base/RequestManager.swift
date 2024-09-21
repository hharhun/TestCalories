import Alamofire
import Core
import Foundation
import Models
import Moya
import Security

// MARK: - BaseRequestService

enum RequestMethod {
    case get
    case post
    case put
    case delete
    case patch
}

// MARK: - RequestManager

class RequestManager {
    //  swiftlint:disable all
    struct BaseTargetType: TargetType {
        var baseURL: URL
        var path: String
        var method: Moya.Method
        var sampleData = Data()
        var task: Task
        var headers: [String: String]?
    }

    func exec<ResponseType: Codable>(
        baseURL: URL,
        path: String,
        parameters: [String: Any]? = nil,
        body: [String: Any]? = [:],
        headers: [String: String]? = nil,
        multipartData: [Moya.MultipartFormData]? = nil,
        method: RequestMethod,
        completion: @escaping Completion<ResponseType>
    ) {
        var task = Task.requestPlain
        if let parameters = parameters, !parameters.isEmpty {
            var newParameters = [String: Any]()
            parameters.forEach {
                guard let value = $0.value as? Any?, let item = value else { return }
                newParameters[$0.key] = item
            }
            task = Task.requestParameters(parameters: newParameters, encoding: URLEncoding.queryString)
        }
        if let body = body, !body.isEmpty {
            var newBody = [String: Any]()
            body.forEach {
                guard let value = $0.value as? Any?, let item = value else { return }
                newBody[$0.key] = item
            }
            if let theJSONData = try? JSONSerialization.data(withJSONObject: newBody, options: []) {
                task = Task.requestCompositeData(bodyData: theJSONData, urlParameters: parameters ?? [:])
            }
        }

        if let data = multipartData {
            task = Task.uploadCompositeMultipart(data, urlParameters: parameters ?? [:])
        }

        let target = BaseTargetType(
            baseURL: baseURL,
            path: path,
            method: moyaMethod(method: method),
            task: task,
            headers: headers
        )
        let endpointClosure: MoyaProvider<BaseTargetType>.EndpointClosure = { _ in
            self.endpoint(target: target)
        }

        print("REQUEST ---> \(target) \n")

        MoyaProvider(endpointClosure: endpointClosure).request(target) { [weak self] result in
            switch result {
            case .success(let response):
                print("RESPONCE ---> \(response.request) \n \(String(decoding: response.data.prefix(response.data.count > 999 ? 999 : response.data.count), as: UTF8.self))")

                guard !response.data.isEmpty else {
                    DispatchQueue.main.async {
                        completion(.error(UIError.empty))
                    }
                    return
                }

                do {
                    let data = try response.map(ResponseType.self)

                    DispatchQueue.main.async {
                        completion(.value(data))
                    }

                } catch {
                    do {
                        guard
                            let response = try response.map([NetworkError].self).first
                        else {
                            return
                        }
                        DispatchQueue.main.async {
                            completion(.error(response))
                        }
                    } catch {
                        guard !response.data.isEmpty else {
                            DispatchQueue.main.async {
                                completion(.error(UIError.empty))
                            }
                            return
                        }
                        DispatchQueue.main.async {
                            completion(.error(error))
                        }
                    }
                }

            case .failure(let error):
                completion(.error(error))
            }
        }
    }

    // swiftlint:enable all

    private func endpoint(target: BaseTargetType) -> Endpoint {
        Endpoint(
            url: URL(target: target).absoluteString.removingPercentEncoding ?? "",
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }

    private func moyaMethod(method: RequestMethod) -> Moya.Method {
        switch method {
        case .get:
            return Moya.Method.get

        case .post:
            return Moya.Method.post

        case .put:
            return Moya.Method.put

        case .delete:
            return Moya.Method.delete

        case .patch:
            return Moya.Method.patch
        }
    }
}

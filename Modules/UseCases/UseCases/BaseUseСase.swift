import Foundation
import Models

public class BaseUseCase {
    let unsecure: UnsecurePropertiesService

    init(
        unsecure: UnsecurePropertiesService
    ) {
        self.unsecure = unsecure
    }

    func serverError(_ error: Error) -> UIError {
        if let error = error as? UIError {
            return error
        } else if let isDevelop: Bool = unsecure.pull(key: .isDevelop), isDevelop {
            if let error = error as? NetworkError {
                return .developError(error.message.orEmpty)
            } else {
                return .developError(error.localizedDescription)
            }
        } else {
            return .server
        }
    }
}

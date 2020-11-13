import Foundation
import Entities
import RxSwift
import FunctionalKit
import Architecture
import NetworkingCommon

struct LoginInterarctorConfiguration {
    let environment: Environment
    let repository: LoginNetworking
    let saveCredential: (_ value: String, _ userAccount: String) -> Result<Void, Error>
}

class LoginIteractor {
    let configuration: LoginInterarctorConfiguration
    
    init(configuration: LoginInterarctorConfiguration) {
        self.configuration = configuration
    }
    
    func doLogin(username: String, password: String) -> Observable<Result<User, ClientError>> {
        configuration.repository.askToLogin(user: username, password: password)
            .map { response -> Result<User, ClientError> in
                switch response {
                case let .success(user):
                    return self.configuration.saveCredential("ACMEPassword", password)
                        .fold(onSuccess: {
                            self.configuration.environment.updateLoggedUser(user: user)
                            return .success(user)
                        },
                        onFailure: { error in
                            //Missing error management
                            return .failure(.badRequest)
                        })
                    
                    //Missing error management
                case .failure:
                    return .failure(.badRequest)
                }
            }
    }
    
}

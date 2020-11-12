import Foundation
import Entities
import RxSwift
import FunctionalKit
import Architecture

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
    
    func doLogin(username: String, password: String) -> Observable<Result<User, Error>> {
        configuration.repository.askToLogin(user: username, password: password)
            .map { response -> Result<User, Error> in
                switch response {
                case let .success(user):
                    return self.configuration.saveCredential("ACMEPassword", password)
                        .fold(onSuccess: {
                            self.configuration.environment.updateLoggedUser(user: user)
                            return .success(user)
                        },
                        onFailure: { error in
                            return .failure(error)
                        })
                case let .failure(error):
                    return .failure(error)
                }
            }
    }
    
}

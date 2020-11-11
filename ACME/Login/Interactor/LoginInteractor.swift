import Foundation
import Entities
import SecureStore
import RxSwift

struct LoginInterarctorConfiguration {
    
    let user: User?
    let repository: LoginNetworking
    let saveCredential: (_ value: String, _ userAccount: String) -> SecureStoreResult<Void>
}

class LoginIteractor {
    let configuration: LoginInterarctorConfiguration
    
    init(configuration: LoginInterarctorConfiguration) {
        self.configuration = configuration
    }
    
    func doLogin(username: String, password: String) -> Observable<User?> {
        configuration.repository.askToLogin(user: username, password: password)
            .map { [weak self] response -> User? in
                switch response {
                case let .success(user):
                    _ = self?.configuration.saveCredential("ACMEPassword", password)
                    return user
                case .failure:
                    return nil
                }
            }
    }
    
}

extension String: Error {}

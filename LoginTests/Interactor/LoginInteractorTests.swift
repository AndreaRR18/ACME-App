import XCTest
@testable import Login
import Architecture
import Entities
import RxSwift
import NetworkingCommon
import ACMESecureStore

class LoginInteractorTests: XCTestCase {
    
    var sut: LoginIteractor!
    let mockConfiguration = LoginInterarctorConfiguration(
        environment: MockEnvironment(),
        repository: MockLoginNetworking(),
        saveCredential: { _,_ in .failure(ACMESecureStoreError.failure) }
    )
    
    override  func setUp() {
        super.setUp()
        sut = LoginIteractor(configuration: mockConfiguration)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
}

fileprivate struct MockEnvironment: Environment {
    var loggedUser: User? = nil
    
    func updateLoggedUser(user: User) {
        print("OK")
    }
    
}

fileprivate struct MockLoginNetworking: LoginNetworking {
    var session: URLSession = .shared
    var baseURL: String = "TEST"
    
    func askToLogin(user: String, password: String) -> Observable<Result<User, ClientError>> {
        .just(.failure(.badRequest))
    }
}

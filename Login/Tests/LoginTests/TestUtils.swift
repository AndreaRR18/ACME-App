@testable import Login
import Architecture
import Entities
import Foundation
import RxSwift
import NetworkingCommon
import ACMESecureStore

struct MockEnvironment: Environment {
    
    let asserDeleteUser: () -> ()
    let asserUpdateUser: (_ user: User) -> ()
    
    func deleteLoggedUser() {
        asserDeleteUser()
    }
    
    var loggedUser: User? = nil
    
    func updateLoggedUser(user: User) {
        asserUpdateUser(user)
    }
    
}

struct MockFailureLoginNetworking: LoginNetworking {
    
    static let shared = MockFailureLoginNetworking()
    
    var session: URLSession = .shared
    var baseURL: String = "TEST"
    
    func askToLogin(user: String, password: String) -> Observable<Result<User, ClientError>> {
        .just(.failure(.badRequest))
    }
}


struct MockSuccessLoginNetworking: LoginNetworking {
    
    let user: User
    
    var session: URLSession = .shared
    var baseURL: String = "TEST"
    
    func askToLogin(user: String, password: String) -> Observable<Result<User, ClientError>> {
        .just(.success(self.user))
    }
}

struct MockLoginRouter: LoginRouter {
    
    var assertMoveOnLoginSucced: () -> ()
    
    func moveOnLoginSucced() {
        assertMoveOnLoginSucced()
    }
    
}

struct MockACMESecureStore: ACMESecureStore {
    
    var set: Result<Void, Error> = .success(())
    var get: Result<String?, Error> = .success("VALUE")
    var remove: Result<Void, Error> = .success(())
    var removeAllValues: Result<Void, Error> = .success(())
    
    func set(_ value: String, for userAccount: String) -> Result<Void, Error> {
        set
    }
    
    func get(for userAccount: String) -> Result<String?, Error> {
        get
    }
    
    func remove(for userAccount: String) -> Result<Void, Error> {
        remove
    }
    
    func removeAll() -> Result<Void, Error> {
        removeAllValues
    }
}

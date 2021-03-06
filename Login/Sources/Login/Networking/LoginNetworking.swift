import Foundation
import RxSwift
import Entities
import NetworkingCommon

public protocol LoginNetworking: WebRepository {
    func askToLogin(user: String, password: String) -> Observable<Result<User, ClientError>>
}

public struct LoginNetworkingImpl: LoginNetworking {
    
    public var session: URLSession
    public var baseURL: String
    
    public init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    public func askToLogin(user: String, password: String) -> Observable<Result<User, ClientError>> {
        call(endpoint: API.askToLogin(user: user, password: password))
    }
}

fileprivate extension LoginNetworkingImpl {
    enum API {
        case askToLogin(user: String, password: String)
    }
}

extension LoginNetworkingImpl.API: APICall {
    var path: String {
        switch self {
        case .askToLogin:
            return "path/to/login"
        }
    }
    
    var method: String { "POST" }
    var headers: [String : String]? { nil }
    
    func body() throws -> Data? {
        switch self {
        case let .askToLogin(user: user, password: password):
            let user = WSLoginModel.Request(username: user, password: password)
            return try? JSONEncoder().encode(user)
        }
    }
    
}


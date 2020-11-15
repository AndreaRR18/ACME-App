import Foundation
import NetworkingCommon
import RxSwift
import Entities

public protocol ContactsListNetworking: WebRepository {
    func getContacts() -> Observable<Result<[Contact], ClientError>>
}

public struct ContactsListNetworkingImpl: ContactsListNetworking {
    
    public var session: URLSession
    public var baseURL: String
    
    public init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    public func getContacts() -> Observable<Result<[Contact], ClientError>> {
        let response: Observable<Result<WSContactsModel.Response, ClientError>>  = call(endpoint: API.getContacts)
        return response.map { result -> Result<[Contact], ClientError> in
            result.map { contacts -> [Contact] in
                contacts.contacts.map {
                    Contact(
                        id: $0.id,
                        firstName: $0.firstName,
                        lastName: $0.lastName,
                        imageData: $0.avatar
                    )
                }
            }
        }
    }
}

fileprivate extension ContactsListNetworkingImpl {
    enum API {
        case getContacts
    }
}

extension ContactsListNetworkingImpl.API: APICall {
    var path: String {
        switch self {
        case .getContacts:
            return "path/to/get/contacts"
        }
    }
    
    var method: String { "GET" }
    var headers: [String : String]? {
        ["jwt-token": "TEOANDADSKVAOSNFAKSL"]
    }
    
    func body() throws -> Data? { nil }
    
}


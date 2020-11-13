import Foundation
import LocalAuthentication

public struct CredentialSecureStore {
    let service: String
    let accessGroup: String?
    
    public init(service: String, accessGroup: String?) {
        self.service = service
        self.accessGroup = accessGroup
    }
}

extension CredentialSecureStore: SecureStoreQueryable {
    public var query: [String : Any] {
        var query: [String:Any] = [:]
        query[String(kSecClass)] = kSecClassGenericPassword
        query[String(kSecAttrService)] = service
        // Access group if target environment is not simulator
        #if !targetEnvironment(simulator)
        if let accessGroup = accessGroup {
          query[String(kSecAttrAccessGroup)] = accessGroup
        }
        #endif
        return query
    }
}

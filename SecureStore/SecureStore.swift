import Foundation
import Security

public typealias SecureStoreResult<Success> = Result<Success, SecureStoreError>

public struct SecureStore {
    public let secureStoreQueryable: SecureStoreQueryable
    
    public init(secureStoreQueryable: SecureStoreQueryable) {
        self.secureStoreQueryable = secureStoreQueryable
    }
    
    public func setValue(_ value: String, for userAccount: String) -> SecureStoreResult<Void> {
        guard let encodedPassword = value.data(using: .utf8) else {
            return .failure(.string2DataConversionError)
        }
        
        var query = secureStoreQueryable.query
        query[String(kSecAttrAccount)] = userAccount
        
        var status = SecItemCopyMatching(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            var attributesToUpdate: [String: Any] = [:]
            attributesToUpdate[String(kSecValueData)] = encodedPassword
            
            status = SecItemUpdate(query as CFDictionary,
                                   attributesToUpdate as CFDictionary)
            if status != errSecSuccess {
                return .failure(error(from: status))
            }
        case errSecItemNotFound:
            query[String(kSecValueData)] = encodedPassword
            
            status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                return .failure(error(from: status))
            }
        default:
            return .failure(error(from: status))
        }
        
        return .success(())
    }
    
    public func getValue(for userAccount: String) -> SecureStoreResult<String?> {
        var query = secureStoreQueryable.query
        query[String(kSecMatchLimit)] = kSecMatchLimitOne
        query[String(kSecReturnAttributes)] = kCFBooleanTrue
        query[String(kSecReturnData)] = kCFBooleanTrue
        query[String(kSecAttrAccount)] = userAccount
        
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, $0)
        }
        
        switch status {
        case errSecSuccess:
            guard
                let queriedItem = queryResult as? [String: Any],
                let passwordData = queriedItem[String(kSecValueData)] as? Data,
                let password = String(data: passwordData, encoding: .utf8)
                else {
                    return .failure(.data2StringConversionError)
            }
            return .success(password)
        case errSecItemNotFound:
            return .success(nil)
        default:
            return .failure(error(from: status))
        }
    }
    
    public func removeValue(for userAccount: String) -> SecureStoreResult<Void> {
        var query = secureStoreQueryable.query
        query[String(kSecAttrAccount)] = userAccount
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            return .failure(error(from: status))
        }
        return .success(())
    }
    
    public func removeAllValues() -> SecureStoreResult<Void> {
        let query = secureStoreQueryable.query
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            return .failure(error(from: status))
        }
        return .success(())
    }
    
    public func error(from status: OSStatus) -> SecureStoreError {
        let message: String
        if #available(iOS 11.3, *) {
            message = SecCopyErrorMessageString(status, nil) as String? ?? NSLocalizedString("Unhandled Error", comment: "")
        } else {
            message = "Unhandled Error"
        }
        return SecureStoreError.unhandledError(message: message)
    }
}

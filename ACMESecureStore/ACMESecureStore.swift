import SecureStore

public enum ACMECredentialSecureStore {
    
    public static func getSecureStore() -> ACMESecureStore {
         SecureStore(
            secureStoreQueryable: CredentialSecureStore(
                service: "ACMECredential",
                accessGroup: nil)
        )
    }
    
}

extension SecureStore: ACMESecureStore {
    public func set(_ value: String, for userAccount: String) -> Result<Void, Error> {
        return setValue(value, for: userAccount)
            .mapError { _ in ACMESecureStoreError.failure }
    }
    
    public func get(for userAccount: String) -> Result<String?, Error> {
        self.getValue(for: userAccount)
            .mapError { _ in ACMESecureStoreError.failure }
    }
    
    public func remove(for userAccount: String) -> Result<Void, Error> {
        self.removeValue(for: userAccount)
            .mapError { _ in ACMESecureStoreError.failure }
    }
    
    public func removeAll() -> Result<Void, Error> {
        self.removeAllValues()
            .mapError { _ in ACMESecureStoreError.failure }
    }
    
}

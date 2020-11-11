import SecureStore

enum ACMECredentialSecureStore {
    
    static func getsSecureStore() -> SecureStore {
         SecureStore(
            secureStoreQueryable: CredentialSecureStore(
                service: "ACMECredential",
                accessGroup: nil)
        )
    }
    
}

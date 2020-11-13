public protocol ACMESecureStore {
    func set(_ value: String, for userAccount: String) -> Result<Void, Error>
    func get(for userAccount: String) -> Result<String?, Error>
    func remove(for userAccount: String) -> Result<Void, Error>
    func removeAll() -> Result<Void, Error>
}

public enum ACMESecureStoreError: Error {
    case failure
}

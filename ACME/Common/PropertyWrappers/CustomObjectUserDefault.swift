import Foundation

@propertyWrapper
struct CustomObjectUserDefault<T: Codable> {
    let key: String

    init(_ key: String) {
        self.key = key
    }

    var wrappedValue: T? {
        get {
            let otpData = UserDefaults.standard.object(forKey: key) as? Data
            guard let data = otpData else { return nil }
            return try? JSONDecoder().decode(T.self, from: data)
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

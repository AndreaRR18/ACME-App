import Foundation

public protocol SecureStoreQueryable {
  var query: [String: Any] { get }
}

import Foundation

public struct Contact: Codable {
    public let firstName: String
    public let lastName: String
    public let imageData: Data
    
    public init(firstName: String, lastName: String, imageData: Data) {
        self.firstName = firstName
        self.lastName = lastName
        self.imageData = imageData
    }
}

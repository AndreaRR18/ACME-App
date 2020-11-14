import Foundation

public struct Contact: Codable, Equatable {
    public let id: String
    public let firstName: String
    public let lastName: String
    public let imageData: Data
    
    public init(
        id: String,
        firstName: String,
        lastName: String,
        imageData: Data
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.imageData = imageData
    }
}

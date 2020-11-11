public struct Contact: Codable {
    public let firstName: String
    public let lastName: String
    public let imageData: String
    
    public init(firstName: String, lastName: String, imageData: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.imageData = imageData
    }
}

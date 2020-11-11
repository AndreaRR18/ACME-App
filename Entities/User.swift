public struct User: Decodable {
    public let username: String?
    public let firstName: String?
    public let lastName: String?
    
    public init(username: String?, firstName: String?, lastName: String?) {
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
    }
}

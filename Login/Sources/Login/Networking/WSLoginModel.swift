enum WSLoginModel {
    struct Request: Encodable {
        let username: String
        let password: String
    }
    
    struct Response: Decodable {
        let username: String
        let firstName: String
        let lastName: String
    }
}

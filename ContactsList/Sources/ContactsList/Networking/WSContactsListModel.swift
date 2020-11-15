import Foundation

enum WSContactsModel {
    struct Request: Encodable {}
    
    struct Response: Decodable {
        var contacts: [WSContactsModel.Contact]
    }
    
    struct Contact: Decodable {
        var id: String
        var firstName: String
        var lastName: String
        var age: String
        var address: String
        var avatar: Data
    }
}

import Entities

public protocol Environment {
    var loggedUser: User? { get }
    var selectedContacts: [Contact] { get }
    
    func updateLoggedUser(user: User)
    func deleteLoggedUser()
    func updateRoomsPartecipand(contacts: [Contact])
}

import Entities

public protocol Environment {
    var loggedUser: User? { get }
    var selectedContacts: [Contact] { get }
    var localContacts: [Contact]? { get }
    
    func updateLoggedUser(user: User)
    func deleteLoggedUser()
    func updateRoomsPartecipand(contacts: [Contact])
    func addLocalContact(_ contact: Contact)
    func removeLocalContact(_ contactId: String)
    func removeAll()
}

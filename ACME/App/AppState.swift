import Entities
import Architecture

class AppState: Environment {
    
    var selectedContacts: [Contact] = []
    @CustomObjectUserDefault("logged_user") var loggedUser: User?
    @CustomObjectUserDefault("local_contacts") var localContacts: [Contact]?
    
    func updateRoomsPartecipand(contacts: [Contact]) {
        selectedContacts = contacts
    }
    
    func updateLoggedUser(user: User) {
        loggedUser = user
    }
    
    func deleteLoggedUser() {
        loggedUser = nil
    }
    
    func addLocalContact(_ contact: Contact) {
        localContacts?.append(contact)
    }
    
    func removeLocalContact(_ contactId: String) {
        localContacts?.removeAll(where: { $0.id == contactId })
        selectedContacts.removeAll(where: { $0.id == contactId })
        print(selectedContacts)
    }
    
    func removeAll() {
        localContacts?.removeAll()
        selectedContacts.removeAll()
    }
    
}

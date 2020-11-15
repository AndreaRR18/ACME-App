import Entities
import Architecture

class AppState: Environment {
    
    var selectedContacts: [Contact] = []
    @CustomObjectUserDefault("logged_user") var loggedUser: User?
    
    func updateRoomsPartecipand(contacts: [Contact]) {
        selectedContacts = contacts
    }
    
    func updateLoggedUser(user: User) {
        loggedUser = user
    }
    
    func deleteLoggedUser() {
        loggedUser = nil
    }
    
}

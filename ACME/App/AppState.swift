import Entities
import Architecture

class AppState: Environment {
    
    @CustomObjectUserDefault("logged_user") var loggedUser: User?
    
    func updateLoggedUser(user: User) {
        loggedUser = user
    }
    
    func deleteLoggedUser() {
        loggedUser = nil
    }
}

import Entities
import Architecture

class AppState: Environment {
    
    @UserDefault("logged_user", defaultValue: nil) var loggedUser: User?
    
    func updateLoggedUser(user: User) {
        loggedUser = user
    }
}

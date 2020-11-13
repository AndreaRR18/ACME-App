import Entities

public protocol Environment {
    var loggedUser: User? { get }
    
    func updateLoggedUser(user: User)
    func deleteLoggedUser()
}

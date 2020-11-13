import Foundation
import RxSwift
import FunctionalKit
import Architecture

struct ContactsListInterarctorConfiguration {
    let environment: Environment
    let repository: ContactsListNetworking
}

class ContactsListIteractor {
    let configuration: ContactsListInterarctorConfiguration
    
    init(configuration: ContactsListInterarctorConfiguration) {
        self.configuration = configuration
    }
    
    func logout() {
        configuration.environment.deleteLoggedUser()
    }
    
}

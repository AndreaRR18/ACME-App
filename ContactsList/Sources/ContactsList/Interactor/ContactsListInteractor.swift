import Foundation
import RxSwift
import FunctionalKit
import Architecture
import Entities

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
    
    func getContacts() -> Observable<[Contact]> {
        configuration.repository
            .getContacts()
            .map { result in
                switch result {
                case let .success(contacts):
                    return contacts
                case .failure:
                    return []
                }
            }
    }
    
}

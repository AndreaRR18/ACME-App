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
    
    func getSelectedItems(contact: Contact, selectedContacts: [Contact]) -> [Contact] {
        var newList = selectedContacts
        if let index = selectedContacts.firstIndex(where: { contact.id == $0.id }) {
            newList.remove(at: index)
        } else {
            newList.append(contact)
        }
        return newList
    }
    
    func buttonIsEnabled(selectedItems: [Contact]) -> Bool {
        let count = selectedItems.count
        if count > 0 && count <= 4 {
            return true
        } else {
            return false
        }
    }
    
}

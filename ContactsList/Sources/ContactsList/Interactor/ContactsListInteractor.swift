import Foundation
import RxSwift
import FunctionalKit
import Architecture
import Entities

struct ContactsListInterarctorConfiguration {
    let environment: Environment
    let repository: ContactsListNetworking
}

struct ContactsListIteractor {
    let configuration: ContactsListInterarctorConfiguration
    
    init(configuration: ContactsListInterarctorConfiguration) {
        self.configuration = configuration
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
    
    func getSelectedItems(contact: Contact) -> [Contact] {
        var newList = configuration.environment.selectedContacts
        if let index = configuration.environment.selectedContacts.firstIndex(where: { contact.id == $0.id }) {
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

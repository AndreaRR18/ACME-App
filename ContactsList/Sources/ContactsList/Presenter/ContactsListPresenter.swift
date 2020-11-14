import Foundation
import RxSwift
import Entities

public class ContactsListPresenter {
    var contactsListInteractor: ContactsListIteractor
    var router: ContactsListRouter
    var contactsListViewState: ContactsListViewState = .starting {
        didSet {
            update(contactsListViewState)
        }
    }
    var update: (ContactsListViewState) -> ()
    var removeAllLocalPassword: () -> Result<Void, Error>
    
    private let disposebag = DisposeBag()
    
    private var contacts: [Contact] = []
    private var selectedContacts: [Contact] = []
    
    init(
        contactsListInteractor: ContactsListIteractor,
        router: ContactsListRouter,
        update: @escaping (ContactsListViewState) -> (),
        removeAllLocalPassword: @escaping () -> Result<Void, Error>
    ) {
        self.contactsListInteractor = contactsListInteractor
        self.router = router
        self.update = update
        self.removeAllLocalPassword = removeAllLocalPassword
    }
    
    func logout() {
        contactsListInteractor.logout()
        router.showLogin()
    }
    
    func showContactsList() {
        contactsListInteractor
            .getContacts()
            .subscribe(onNext: { contacts in
                self.contacts = contacts
                self.contactsListViewState.update(
                    contacts: contacts.map { contact in
                        ConctactCellViewState(
                            firstName: contact.firstName,
                            lastName: contact.lastName,
                            image: contact.imageData,
                            isSelected: self.selectedContacts.contains(contact),
                            contactsId: contact.id
                        )
                    }
                )
            }).disposed(by: disposebag)
    }
    
    func itemSelected(contactId: String) {
        guard let contact = contacts.first(where: { $0.id == contactId })
        else { return }
        selectedContacts = contactsListInteractor
            .getSelectedItems(contact: contact, selectedContacts: selectedContacts)
       
        contactsListViewState.update(
            contacts: contacts.map { contact in
                ConctactCellViewState(
                    firstName: contact.firstName,
                    lastName: contact.lastName,
                    image: contact.imageData,
                    isSelected: selectedContacts.contains(contact),
                    contactsId: contact.id
                )
            }
        )
        
        contactsListViewState.buttonIsVisible(
            contactsListInteractor
                .buttonIsEnabled(selectedItems: selectedContacts)
        )
    }
    
}

fileprivate extension ContactsListViewState {
    mutating func update(contacts: [ConctactCellViewState]) {
        self.contacts = contacts
    }
    
    mutating func buttonIsVisible(_ bool: Bool) {
        self.isButtonEnabled = bool
    }
}

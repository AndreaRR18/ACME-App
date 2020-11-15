import Foundation
import RxSwift
import Entities
import Architecture

public class ContactsListPresenter {
    
    var environment: Environment
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
    
    init(
        environment: Environment,
        contactsListInteractor: ContactsListIteractor,
        router: ContactsListRouter,
        update: @escaping (ContactsListViewState) -> (),
        removeAllLocalPassword: @escaping () -> Result<Void, Error>
    ) {
        self.environment = environment
        self.contactsListInteractor = contactsListInteractor
        self.router = router
        self.update = update
        self.removeAllLocalPassword = removeAllLocalPassword
    }
    
    func logout() {
        environment.deleteLoggedUser()
        environment.removeAll()
        contacts = .empty
        updateList()
        router.showLogin()
    }
        
    func showContactsList() {
        contactsListInteractor
            .getContacts()
            .subscribe(onNext: { [weak self] contacts in
                guard let self = self else { return }
                self.contacts = contacts + self.environment.localContacts.get(or: .empty)
                self.updateList()
            }).disposed(by: disposebag)
    }
    
    func itemSelected(contactId: String) {
        guard let contact = contacts.first(where: { $0.id == contactId })
        else { return }
        environment.updateRoomsPartecipand(
            contacts: contactsListInteractor
                .getSelectedItems(contact: contact)
        )
        
        contactsListViewState.update(
            contacts: contacts.map { contact in
                ConctactCellViewState(
                    firstName: contact.firstName,
                    lastName: contact.lastName,
                    image: contact.imageData,
                    isSelected: environment.selectedContacts.contains(contact),
                    contactsId: contact.id
                )
            }
        )
        
        contactsListViewState.buttonIsVisible(
            contactsListInteractor
                .buttonIsEnabled(selectedItems: environment.selectedContacts)
        )
    }
    
    func startCall() {
        router.startConversation()
    }
    
    func addNewLocalContact(_ contact: Contact) {
        environment.addLocalContact(contact)
        showContactsList()
    }
    
    func removeLocalContact(_ contactId: String) {
        environment.removeLocalContact(contactId)
        contactsListViewState.buttonIsVisible(
            contactsListInteractor
                .buttonIsEnabled(selectedItems: environment.selectedContacts)
        )
        
        showContactsList()
    }
    
    private func updateList() {
        contactsListViewState.update(
            contacts: contacts.map { contact in
                ConctactCellViewState(
                    firstName: contact.firstName,
                    lastName: contact.lastName,
                    image: contact.imageData,
                    isSelected: environment.selectedContacts.contains(contact),
                    contactsId: contact.id
                )
            }
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

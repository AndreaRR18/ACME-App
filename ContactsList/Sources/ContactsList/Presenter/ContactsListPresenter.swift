import Foundation
import RxSwift

public class ContactsListPresenter {
    var contactsListInteractor: ContactsListIteractor
    var router: ContactsListRouter
    var contactsListViewState: ContactsListViewState = .starting
    var update: (ContactsListViewState) -> ()
    var removeAllLocalPassword: () -> Result<Void, Error>
    
    private let disposebag = DisposeBag()
    
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
                let contactsViewState = contacts.map {
                    ConctactCellViewState(
                        firstName: $0.firstName,
                        lastName: $0.lastName,
                        image: $0.imageData
                    )
                }
                self.update(self.contactsListViewState.update(contacts: contactsViewState))
            }).disposed(by: disposebag)
    }
}

fileprivate extension ContactsListViewState {
    func update(contacts: [ConctactCellViewState]) -> ContactsListViewState {
        var newVS = self
        newVS.contacts = contacts
        return newVS
    }
}

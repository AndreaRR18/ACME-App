import Foundation
import RxSwift

public class ContactsListPresenter {
    var contactsListInteractor: ContactsListIteractor
    var router: ContactsListRouter
    var loginViewState: ContactsListViewState = .starting
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
        
    }
}

fileprivate extension ContactsListViewState {
    
}

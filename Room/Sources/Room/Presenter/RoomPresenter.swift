import RxSwift
import Entities
import Architecture
import FunctionalKit

public class RoomPresenter {
    var interactor: RoomInteractor
    var router: RoomRouter
    var environment: Environment
    
    var viewState: RoomViewState = .starting {
        didSet {
            update(viewState)
        }
    }
    
    var update: (RoomViewState) -> ()
    
    private let disposeBag = DisposeBag()
    
    init(interactor: RoomInteractor,
         router: RoomRouter,
         environment: Environment,
         update: @escaping (RoomViewState) -> ()
    ) {
        self.interactor = interactor
        self.router = router
        self.environment = environment
        self.update = update
    }
    
    func closeRoom() {
        router.closeRoom()
    }
    
    func startCall() {
        interactor
            .startCall(with: environment.selectedContacts)
            .subscribe(onNext:  { self.viewState.updateRoomContacts(contacts: $0) })
            .disposed(by: disposeBag)
    }
}

fileprivate extension RoomViewState {
    mutating func updateRoomContacts(contacts: [Pair<Contact, Stream>]) {
        self.contacts = contacts
    }
}

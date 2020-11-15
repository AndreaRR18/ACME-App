import RxSwift

public class RoomPresenter {
    var interactor: RoomInteractor
    var router: RoomRouter
    var viewState: RoomViewState = .starting {
        didSet {
            update(viewState)
        }
    }
    
    var update: (RoomViewState) -> ()
    
    private let disposeBag = DisposeBag()
    
    init(interactor: RoomInteractor,
         router: RoomRouter,
         update: @escaping (RoomViewState) -> ()) {
        self.interactor = interactor
        self.router = router
        self.update = update
    }
    
    func closeRoom() {
        router.closeRoom()
    }
}

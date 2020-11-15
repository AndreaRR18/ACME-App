import Architecture

public protocol RoomRouter {
    func closeRoom()
}

public class RoomRouterImpl: RoomRouter {
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    public func closeRoom() {
        router.dismissPage(animated: true, completion: nil)
    }

    
}

import UIKit

protocol LoginRouter {
    func moveOnLoginSucced()
}

class LoginRouterImpl: LoginRouter {
    
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func moveOnLoginSucced() {
        router.dismissModule(animated: true, completion: nil)
    }
}

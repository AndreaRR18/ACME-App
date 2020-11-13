import Architecture

protocol LoginRouter {
    func moveOnLoginSucced()
}

class LoginRouterImpl: LoginRouter {
    
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func moveOnLoginSucced() {
        router.dismissPage(animated: true, completion: nil)
    }
}

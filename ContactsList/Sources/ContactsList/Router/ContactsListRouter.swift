import Architecture
import FunctionalKit

protocol ContactsListRouter {
    func showLogin()
    func startConversation()
}

class ContactListRouterImpl: ContactsListRouter {
    
    let router: Router
    let getLoginPage: Effect<Presentable>
    let getConversationPage: Effect<Presentable>
    
    init(
        router: Router,
        getLoginPage: Effect<Presentable>,
        getConversationPage: Effect<Presentable>
    ) {
        self.router = router
        self.getLoginPage = getLoginPage
        self.getConversationPage = getConversationPage
    }
    
    func showLogin() {
        router.presentPage(getLoginPage.run(), animated: true, nil)
    }
    
    func startConversation() {
        router.presentPage(getConversationPage.run(), animated: true, nil)
    }
}

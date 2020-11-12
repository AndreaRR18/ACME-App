import UIKit
import Entities
import FunctionalKit
import ACMESecureStore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var secureStore = ACMECredentialSecureStore.getSecureStore()
    lazy var appState = AppState()
    
    lazy var pageFactory = PageFactory(
        secureStore: secureStore,
        environment: appState
    )
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            
            if appState.loggedUser.isNil {
                window.rootViewController = UINavigationController(rootViewController: pageFactory.getLoginPage())
            } else {
                window.rootViewController = UINavigationController(rootViewController: pageFactory.getContactPage())
            }
            
            window.makeKeyAndVisible()
        }
        return true
    }
    
}


import UIKit
import Entities
import FunctionalKit
import ACMESecureStore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var secureStore = ACMECredentialSecureStore.getSecureStore()
    lazy var appState = AppState()
    lazy var navigationController = UINavigationController()

    lazy var pageFactory = PageFactory(
        secureStore: secureStore,
        environment: appState,
        mainNavController: navigationController
    )
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            
            window.rootViewController = pageFactory.rootPage
            
            window.makeKeyAndVisible()
        }
        return true
    }
    
}


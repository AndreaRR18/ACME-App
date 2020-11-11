import UIKit
import Entities

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let baseURL = "BASE_URL"
    
    lazy var secureStore = ACMECredentialSecureStore.getsSecureStore()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            
            let viewController = LoginPage(
                user: User(username: "", firstName: "", lastName: ""),
                networking: LoginNetworkingImpl(session: .shared, baseURL: baseURL),
                secureStore: secureStore
            )
            
            window.rootViewController = UINavigationController(rootViewController: viewController)
            window.makeKeyAndVisible()
        }
        return true
    }
    
}


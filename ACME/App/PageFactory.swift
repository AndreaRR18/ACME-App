import Foundation
import UIKit
import ACMESecureStore
import Login

class PageFactory {
    
    let secureStore: ACMESecureStore
    let environment: AppState
    let session: URLSession
    let baseURL: String
    
    init(
        secureStore: ACMESecureStore,
        environment: AppState,
        session: URLSession = .shared,
        baseURL: String = "BASE_URL"
    ) {
        self.secureStore = secureStore
        self.environment = environment
        self.session = session
        self.baseURL = baseURL
    }
    
    func getLoginPage() -> LoginPage {
        LoginPage(
            environment: environment,
            networking: LoginNetworkingImpl(
                session: session,
                baseURL: baseURL
            ),
            secureStore: secureStore
        )
    }
    
    func getContactPage() -> UIViewController {
        return UIViewController()
    }

}

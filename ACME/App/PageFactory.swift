import Foundation
import UIKit
import ACMESecureStore
import Login
import Entities
import RxSwift
import NetworkingCommon
import ContactsList
import FunctionalKit

class PageFactory {
    
    let secureStore: ACMESecureStore
    let environment: AppState
    let session: URLSession
    let baseURL: String
    let mainNavController: UINavigationController
    
    init(
        secureStore: ACMESecureStore,
        environment: AppState,
        session: URLSession = .shared,
        baseURL: String = "BASE_URL",
        mainNavController: UINavigationController
    ) {
        self.secureStore = secureStore
        self.environment = environment
        self.session = session
        self.baseURL = baseURL
        self.mainNavController = mainNavController
    }
    
    private(set) lazy var rootPage: UINavigationController = mainNavController |> f.with { (navController) in
        navController.setViewControllers([self.contactsListPage], animated: false)
        self.showLoginIfNeeded()
    }
    
    private(set) lazy var loginPage = LoginPage(
            environment: environment,
            networking: LoginiNetworkingMock(),
            secureStore: secureStore
        )
    
    private(set) lazy var contactsListPage = ContactListPage(
            environment: environment,
            networking: ContactsListNetworkingMock(),
            getLogin: .pure(loginPage),
            getConversationPage: .pure(UIViewController()), secureStore: secureStore
        )
    
    private func showLoginIfNeeded() {
        if self.environment.loggedUser.isNil {
            DispatchQueue.main.async {
                self.loginPage.modalPresentationStyle = .fullScreen
                self.mainNavController.present(self.loginPage, animated: true, completion: nil)
            }
        }
    }
}

fileprivate struct LoginiNetworkingMock: LoginNetworking {
    func askToLogin(user: String, password: String) -> Observable<Result<User, ClientError>> {
        .just(.success(User(username: "arinaldi", firstName: "Andrea", lastName: "Rinaldi")))
    }
    
    var session: URLSession = .shared
    
    var baseURL: String = ""
    
}

fileprivate struct ContactsListNetworkingMock: ContactsListNetworking {
    func getContacts() -> Observable<Result<[Contact], ClientError>> {
        .just(.success([]))
    }
    
    var session: URLSession = .shared
    
    var baseURL: String = ""
    
}


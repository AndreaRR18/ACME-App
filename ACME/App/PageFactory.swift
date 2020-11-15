import Foundation
import UIKit
import ACMESecureStore
import Login
import Entities
import RxSwift
import NetworkingCommon
import ContactsList
import FunctionalKit
import Room

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
    
    private lazy var loginPage = LoginPage(
        environment: environment,
        networking: LoginiNetworkingMock(),
        secureStore: secureStore
    )
    
    private lazy var contactsListPage = ContactListPage(
        environment: environment,
        networking: ContactsListNetworkingMock(),
        getLogin: .pure(loginPage),
        getConversationPage: .pure(roomPage), secureStore: secureStore,
        generateLocalContact: Effect {
            Contact(
                id: "\(Int.random(in: 0...99999))",
                firstName: String.getRanomName(),
                lastName: String.getRanomName(),
                imageData: ["1","2","3","4"].randomElement()!.getImageName().jpegData(compressionQuality: 1)!
            )
        }
    )
    
    private lazy var roomPage = RoomPage(
        environment: environment,
        networking: RoomNetworkingMock()
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
        .just(.success([
            Contact(
                id: "1",
                firstName: "Andrea",
                lastName: "Rinaldi",
                imageData: UIImage(named: "image")!.jpegData(compressionQuality: 1)!),
            Contact(
                id: "2",
                firstName: "Chiara",
                lastName: "Boccia",
                imageData: UIImage(named: "image2")!.jpegData(compressionQuality: 1)!),
            Contact(
                id: "3",
                firstName: "Marisa",
                lastName: "Bianchi",
                imageData: UIImage(named: "image3")!.jpegData(compressionQuality: 1)!),
            Contact(
                id: "4",
                firstName: "Giorgio",
                lastName: "Mastrota",
                imageData: UIImage(named: "image4")!.jpegData(compressionQuality: 1)!),
            Contact(
                id: "5",
                firstName: "Maria",
                lastName: "Morrone",
                imageData: UIImage(named: "image3")!.jpegData(compressionQuality: 1)!)
        ]))
    }
    
    var session: URLSession = .shared
    
    var baseURL: String = ""
    
}

fileprivate struct RoomNetworkingMock: RoomNetworking {
    
    var session: URLSession = .shared
    var baseURL: String = ""
    
    func startCall(with contact: Contact) -> Observable<Result<ACMEStream, ClientError>> {
        Observable
            .just(
                Result.success(
                    ACMEStream(
                        hasAudio: Bool.random(),
                        hasVideo: Bool.random(),
                        stream: contact.id.getImageName().jpegData(compressionQuality: 0)!)
                ))
    }
    
}

fileprivate extension String {
    func getImageName() -> UIImage {
        guard let id = Int(self) else { return UIImage() }
        switch id {
        case 1:
            return UIImage(named: "image")!
        case 2:
            return UIImage(named: "image2")!
        case 3:
            return UIImage(named: "image3")!
        case 4:
            return UIImage(named: "image4")!
        default:
            return UIImage(named: "image")!
        }
    }
}

fileprivate extension String {
    static func getRanomName() -> String {
        [
            "CaioCalogero", "Calypso", "Camelia", "Cameron", "Camilla", "Camillo", "Candida", "Candido", "Carina", "Carla", "Carlo", "Carmela", "Carmelo", "Carolina", "Cassandra", "Caterina", "Cecilia", "Cedric", "Celesta", "Celeste", "Cesara", "Cesare", "Chandra", "Chantal", "Chiara", "Cino", "Cinzia", "Cirillo", "Ciro", "Claudia", "Claudio", "Clelia", "Clemente", "Clio", "Clizia", "Cloe", "Clorinda", "Clotilde", "Concetta", "Consolata", "Contessa", "Cora", "Cordelia", "Corinna", "Cornelia", "Corrado", "Cosetta", "Cosimo", "Costantino", "Costanza", "Costanzo", "Cristal", "Cristiana", "Cristiano", "Cristina", "Cristoforo", "Cruz", "Curzio"
        ].randomElement()!
    }
}

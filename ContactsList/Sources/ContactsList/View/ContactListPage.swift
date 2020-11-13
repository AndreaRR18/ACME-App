import UIKit
import FunctionalKit
import Architecture
import ACMESecureStore

public class ContactListPage: UIViewController {
    
    public typealias ViewState = ContactsListViewState
    public typealias Presenter = ContactsListPresenter
    
    let environment: Environment
    let networking: ContactsListNetworking
    public var presenter: ContactsListPresenter?
    let getLogin: Effect<Presentable>
    let getConversationPage: Effect<Presentable>
    let secureStore: ACMESecureStore
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var adapter = ContactsListAdapter()
    
    public init(
        environment: Environment,
        networking: ContactsListNetworking,
        getLogin: Effect<Presentable>,
        getConversationPage: Effect<Presentable>,
        secureStore: ACMESecureStore
    ) {
        self.environment = environment
        self.networking = networking
        self.getLogin = getLogin
        self.getConversationPage = getConversationPage
        self.secureStore = secureStore
        
        super.init(nibName: "ContactListPage", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logoutTapped)
        )
        
        presenter = ContactsListPresenter(
            contactsListInteractor: ContactsListIteractor(
                configuration: .init(
                    environment: environment,
                    repository: networking
                )
            ),
            router: ContactListRouterImpl(
                router: self.navigationController!,
                getLoginPage: getLogin,
                getConversationPage: getConversationPage
            ),
            update: update,
            removeAllLocalPassword: secureStore.removeAll)
        
        adapter.attach(tableView: tableView)
        
        presenter?.showContactsList()
    }
    
    
    public func update(_ viewState: ContactsListViewState) {
        adapter.contactListViewState = viewState.contacts
    }
    
    @objc func logoutTapped() {
        presenter?.logout()
    }
    
}

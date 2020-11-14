import UIKit
import FunctionalKit
import Architecture
import ACMESecureStore

public class ContactListPage: UIViewController, PageType {
    
    public typealias ViewState = ContactsListViewState
    public typealias Presenter = ContactsListPresenter
    
    let environment: Environment
    let networking: ContactsListNetworking
    public var presenter: ContactsListPresenter?
    let getLogin: Effect<Presentable>
    let getConversationPage: Effect<Presentable>
    let secureStore: ACMESecureStore
    
    private let tableView = UITableView()
    
    private let startCallButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start call", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
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
        
        super.init(nibName: nil, bundle: nil)
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
        
        adapter.attach(tableView: tableView, presenter: presenter)
        
        presenter?.showContactsList()
        setupTableView()
        setupUIButton()
    }
    
    public func update(_ viewState: ContactsListViewState) {
        startCallButton.isHidden = viewState.isButtonEnabled.not
        adapter.contactListViewState = viewState.contacts
    }
    
    @objc func logoutTapped() {
        presenter?.logout()
    }
    
    @objc func startButtonTapped() {
        print("TAP")
    }
    
    private func setupUIButton() {
        startCallButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startCallButton)
        NSLayoutConstraint.activate([
            startCallButton.heightAnchor.constraint(equalToConstant: 50),
            startCallButton.widthAnchor.constraint(equalToConstant: 200),
            startCallButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            startCallButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

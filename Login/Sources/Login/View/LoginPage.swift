import UIKit
import RxSwift
import Entities
import ACMESecureStore
import Architecture
import FunctionalKit

public class LoginPage: UIViewController, PageType {
    
    public typealias ViewState = LoginViewState
    typealias Presesnter = LoginPresenter
    
    public var presenter: LoginPresenter?
    let environment: Environment
    let networking: LoginNetworking
    let secureStore: ACMESecureStore
    let disposeBag = DisposeBag()
    
    public init(
        environment: Environment,
        networking: LoginNetworking,
        secureStore: ACMESecureStore
    ) {
        self.environment = environment
        self.networking = networking
        self.secureStore = secureStore
        super.init(nibName: "LoginPage", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            userTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.addTarget(self, action: #selector(askToLogin), for: .allEvents)
        }
    }
    @IBOutlet weak var errorLabel: UILabel! {
        didSet {
            errorLabel.textAlignment = .center
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(
            loginInteractor: LoginIteractor(
                configuration: LoginInterarctorConfiguration(
                    environment: environment,
                    repository: networking,
                    saveCredential: secureStore.set
                )
            ),
            router: LoginRouterImpl(router: self),
            update: update
        )
        
    }
    
    public func update(_ viewState: LoginViewState) {
        loginButton.isEnabled = viewState.buttonEnabled
        errorLabel.text = viewState.errorMessage
    }
    
    @objc private func textFieldChange() {
        self.presenter?.loginChange(username: self.userTextField.text, password: self.passwordTextField.text)
    }
    
    @objc private func askToLogin() {
        guard let username = self.userTextField.text,
              let password = self.passwordTextField.text
        else { return }
        self.presenter?.askToLogin(username: username, password: password)
    }
    
}
 

import UIKit
import RxSwift
import RxCocoa
import Entities
import SecureStore

class LoginPage: UIViewController, Page {
    
    typealias ViewState = LoginViewState
    
    private(set) var presenter: LoginPresenter?
    let user: User
    let networking: LoginNetworking
    let secureStore: SecureStore
    
    init(user: User, networking: LoginNetworking, secureStore: SecureStore) {
        self.user = user
        self.networking = networking
        self.secureStore = secureStore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            userTextField.rx.text.subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                self.presenter?.loginChange(username: self.userTextField.text, password: self.passwordTextField.text)
            })
            .disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.rx.text.subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                self.presenter?.loginChange(username: self.userTextField.text, password: self.passwordTextField.text)
            })
            .disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.rx.tap.subscribe(onNext: { [weak self] in
                guard let self = self,
                      let username = self.userTextField.text,
                      let password = self.passwordTextField.text
                else { return }
                self.presenter?.askToLogin(username: username, password: password)
            }).disposed(by: disposeBag)
        }
    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(
            loginInteractor: LoginIteractor(configuration: .init(
                user: nil,
                repository: networking,
                saveCredential: secureStore.setValue
            )),
            router: LoginRouterImpl(router: self),
            update: self.update)
    }
    
    func update(_ viewState: LoginViewState) {
        loginButton.isEnabled = viewState.buttonEnabled
    }
    
}

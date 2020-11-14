import Foundation
import RxSwift

public class LoginPresenter {
    var loginInteractor: LoginIteractor
    var router: LoginRouter
    var loginViewState: LoginViewState = .starting {
        didSet {
            update(loginViewState)
        }
    }
    var update: (LoginViewState) -> ()
    
    private let disposebag = DisposeBag()
    
    init(loginInteractor: LoginIteractor, router: LoginRouter, update: @escaping (LoginViewState) -> ()) {
        self.loginInteractor = loginInteractor
        self.router = router
        self.update = update
        update(loginViewState)
    }
    
    func loginChange(username: String?, password: String?) {
        let usr = username?.isEmpty
        let psw = password?.isEmpty
        
        if usr == false && psw == false {
            loginViewState.setLoginButtonEnabled(true)
        } else {
            loginViewState.setLoginButtonEnabled(false)
        }
        
    }
    
    func askToLogin(username: String, password: String) {
        loginViewState.startLoading()
        loginViewState.setLoginButtonEnabled(false)
        loginViewState.showError(message: "")
        loginInteractor
            .doLogin(username: username, password: password)
            .observeOn(MainScheduler())
            .subscribe(onNext: { [weak self]  result in
                guard let self = self else { return }
                self.loginViewState.stopLoading()
                self.loginViewState.setLoginButtonEnabled(true)
                switch result {
                case .success:
                    self.loginViewState.startLoading()
                    self.router.moveOnLoginSucced()
                case .failure:
                    self.loginViewState.showError(message: "Credenziali errate")
                }
            })
            .disposed(by: disposebag)
        
    }
    
}

fileprivate extension LoginViewState {
    mutating func setLoginButtonEnabled(_ value: Bool) {
        buttonEnabled = value
    }
    
    mutating func startLoading() {
        isLoading = true
    }
    
    mutating func stopLoading() {
        isLoading = false
    }
    
    mutating func showError(message: String) {
        errorMessage = message
    }
}

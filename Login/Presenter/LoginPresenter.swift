import Foundation
import RxSwift

public class LoginPresenter {
    var loginInteractor: LoginIteractor
    var router: LoginRouter
    var loginViewState: LoginViewState = .starting
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
            update(self.loginViewState.setLoginButtonEnabled(true))
        } else {
            update(self.loginViewState.setLoginButtonEnabled(false))
        }
    }
    
    func askToLogin(username: String, password: String) {
        update(self.loginViewState.startLoading())
        update(self.loginViewState.setLoginButtonEnabled(false))
        update(self.loginViewState.showError(message: ""))
        loginInteractor
            .doLogin(username: username, password: password)
            .observeOn(MainScheduler())
            .subscribe(onNext: { [weak self]  result in
                guard let self = self else { return }
                self.update(self.loginViewState.stopLoading())
                self.update(self.loginViewState.setLoginButtonEnabled(true))
                switch result {
                case .success:
                    self.router.moveOnLoginSucced()
                case .failure:
                    self.update(self.loginViewState.showError(message: "Credenziali errate"))
                }
            })
            .disposed(by: disposebag)
        
    }
    
}

fileprivate extension LoginViewState {
    func setLoginButtonEnabled(_ value: Bool) -> LoginViewState {
        var newVS = self
        newVS.buttonEnabled = value
        return newVS
    }
    
    func startLoading() -> LoginViewState {
        var newVS = self
        newVS.isLoading = true
        return newVS
    }
    
    func stopLoading() -> LoginViewState {
        var newVS = self
        newVS.isLoading = false
        return newVS
    }
    
    func showError(message: String) -> LoginViewState {
        var newVS = self
        newVS.errorMessage = message
        return newVS
    }
}

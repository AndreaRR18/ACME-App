import Foundation

class LoginPresenter {
    var loginInteractor: LoginIteractor
    var router: LoginRouter
    var loginViewState: LoginViewState = .starting
    var update: (LoginViewState) -> ()
    
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
        
        loginInteractor
            .doLogin(username: username, password: password)
            
    }
    
}

fileprivate extension LoginViewState {
    func setLoginButtonEnabled(_ value: Bool) -> LoginViewState {
        var newVS = self
        newVS.buttonEnabled = value
        return newVS
    }
}

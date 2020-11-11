import Foundation

struct LoginViewState {
    var username: String?
    var password: String?
    var isLoading: Bool
    var buttonEnabled: Bool
}

extension LoginViewState {
    static let starting = LoginViewState(isLoading: false, buttonEnabled: false)
}

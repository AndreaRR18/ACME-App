import Foundation

public struct LoginViewState {
    public var username: String?
    public var password: String?
    public var errorMessage: String?
    public var isLoading: Bool
    public var buttonEnabled: Bool
}

extension LoginViewState {
    static let starting = LoginViewState(isLoading: false, buttonEnabled: false)
}

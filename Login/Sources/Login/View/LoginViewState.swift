import Foundation

public struct LoginViewState: Equatable {
    public var errorMessage: String?
    public var isLoading: Bool
    public var buttonEnabled: Bool
}

extension LoginViewState {
    static let starting = LoginViewState(isLoading: false, buttonEnabled: false)
}

import XCTest
@testable import Login
import RxSwift
import Entities

class LoginPresenterTests: XCTestCase {

    var sut: LoginPresenter!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testloginChange_OnlyUsername() {

        let usr: String? = "USER"
        let pwd: String? = nil

        let expected = LoginViewState(
            errorMessage: nil,
            isLoading: false,
            buttonEnabled: false
        )

        let loginInteractor = LoginIteractor(
            configuration: LoginInterarctorConfiguration(
                environment: MockEnvironment(
                    asserDeleteUser: { XCTFail() },
                    asserUpdateUser: { _ in XCTFail() }
                ),
                repository: MockFailureLoginNetworking.shared,
                saveCredential: { _,_ in
                    XCTFail()
                    fatalError()
                }
            ))

        let sut = LoginPresenter(
            loginInteractor: loginInteractor,
            router: MockLoginRouter(
                assertMoveOnLoginSucced: {
                    XCTFail()
                }),
            update: { newVS in
                XCTAssertEqual(newVS, expected)
            })
        sut.loginChange(username: usr, password: pwd)

    }

    func testloginChange_OnlyPassword() {

        let usr: String? = nil
        let pwd: String? = "PWD"

        let expected = LoginViewState(
            errorMessage: nil,
            isLoading: false,
            buttonEnabled: false
        )

        let loginInteractor = LoginIteractor(
            configuration: LoginInterarctorConfiguration(
                environment: MockEnvironment(
                    asserDeleteUser: { XCTFail() },
                    asserUpdateUser: { _ in XCTFail() }
                ),
                repository: MockFailureLoginNetworking.shared,
                saveCredential: { _,_ in
                    XCTFail()
                    fatalError()
                }
            ))

        let sut = LoginPresenter(
            loginInteractor: loginInteractor,
            router: MockLoginRouter(
                assertMoveOnLoginSucced: {
                    XCTFail()
                }),
            update: { newVS in
                XCTAssertEqual(newVS, expected)
            })
        sut.loginChange(username: usr, password: pwd)

    }

    func testloginChange_BothField() {

        let usr: String? = "USR"
        let pwd: String? = "PWD"

        let expected = LoginViewState(
            errorMessage: nil,
            isLoading: false,
            buttonEnabled: true
        )

        let loginInteractor = LoginIteractor(
            configuration: LoginInterarctorConfiguration(
                environment: MockEnvironment(
                    asserDeleteUser: { XCTFail() },
                    asserUpdateUser: { _ in XCTFail() }
                ),
                repository: MockFailureLoginNetworking.shared,
                saveCredential: { _,_ in
                    XCTFail()
                    fatalError()
                }
            ))

        var finalVS: LoginViewState!

        let sut = LoginPresenter(
            loginInteractor: loginInteractor,
            router: MockLoginRouter(assertMoveOnLoginSucced: { XCTFail() }),
            update: { newVS in finalVS = newVS })

        sut.loginChange(username: usr, password: pwd)

        XCTAssertEqual(finalVS, expected)

    }

    func testAskToLogin_Success() {

        let usr: String = "USR"
        let pwd: String = "PWD"

        let responseUser = User(username: "USR", firstName: "FN", lastName: "LN")
        let expected = LoginViewState(
            errorMessage: nil,
            isLoading: false,
            buttonEnabled: false
        )

        let loginInteractor = LoginIteractor(
            configuration: LoginInterarctorConfiguration(
                environment: MockEnvironment(
                    asserDeleteUser: { XCTFail() },
                    asserUpdateUser: { user in XCTAssertEqual(responseUser, user) }
                ),
                repository: MockSuccessLoginNetworking(user: responseUser),
                saveCredential: { _,_ in
                    XCTAssertTrue(true)
                    return .success(())
                }
            ))

        var finalVS: LoginViewState!

        let sut = LoginPresenter(
            loginInteractor: loginInteractor,
            router: MockLoginRouter(
                assertMoveOnLoginSucced: { XCTAssertTrue(true) }
            ),
            update: { newVS in finalVS = newVS })

        sut.askToLogin(username: usr, password: pwd)

        XCTAssertEqual(finalVS, expected)

    }

    func testAskToLogin_Failure() {

        let usr: String = "USR"
        let pwd: String = "PWD"

        let expected = LoginViewState(
            errorMessage: "Credenziali errate",
            isLoading: false,
            buttonEnabled: false
        )

        let loginInteractor = LoginIteractor(
            configuration: LoginInterarctorConfiguration(
                environment: MockEnvironment(
                    asserDeleteUser: { XCTFail() },
                    asserUpdateUser: { _ in XCTFail() }
                ),
                repository: MockFailureLoginNetworking.shared,
                saveCredential: { _,_ in
                    XCTFail()
                    fatalError()
                }
            ))

        var finalVS: LoginViewState!

        let sut = LoginPresenter(
            loginInteractor: loginInteractor,
            router: MockLoginRouter(
                assertMoveOnLoginSucced: { XCTFail() }
            ),
            update: { newVS in finalVS = newVS })

        sut.askToLogin(username: usr, password: pwd)

        XCTAssertEqual(finalVS, expected)

    }



}


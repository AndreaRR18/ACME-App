import XCTest
@testable import Login
import RxBlocking
import Entities
import NetworkingCommon

class LoginInteractorTests: XCTestCase {

    var sut: LoginIteractor!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testDoLogin_LoginFailed() {

        sut = LoginIteractor(
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
        let result = sut.doLogin(username: "USR", password: "PSW")
        XCTAssertEqual(
            try result.toBlocking().first(),
            Result<User, ClientError>.failure(.badRequest)
        )

    }

    func testDoLogin_LoginSuccess() {
        let responseUser = User(username: "USR", firstName: "FName", lastName: "LName")
        sut = LoginIteractor(
            configuration: LoginInterarctorConfiguration(
                environment: MockEnvironment(
                    asserDeleteUser: { XCTFail() },
                    asserUpdateUser: { user in
                        XCTAssertEqual(user, responseUser)
                    }
                ),
                repository: MockSuccessLoginNetworking(user: responseUser),
                saveCredential: { value, pass in
                    XCTAssertEqual("ACMEPassword", value)
                    XCTAssertEqual("PSW", pass)
                    return .success(())
                }
            ))
        let result = sut.doLogin(username: "USR", password: "PSW")
        XCTAssertEqual(
            try result.toBlocking().first(),
            Result<User, ClientError>.success(responseUser)
        )

    }

}


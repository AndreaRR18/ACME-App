@testable import Login
import XCTest
import Entities

class LoginPageTests: XCTestCase {
    
    var sut: LoginPage!
    
    override func setUp() {
        super.setUp()
        sut = LoginPage(
            environment: MockEnvironment(
                asserDeleteUser: {
                    XCTFail()
                },
                asserUpdateUser: { _ in
                    XCTFail()
                }),
            networking: MockSuccessLoginNetworking(
                user: User(username: nil, firstName: nil, lastName: nil)
            ),
            secureStore: MockACMESecureStore()
        )
        _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testUpdate_EmptyPage() {
        
        let vs = LoginViewState(
            errorMessage: nil,
            isLoading: false,
            buttonEnabled: false
        )
        
        sut.update(vs)
    }
    
    
}

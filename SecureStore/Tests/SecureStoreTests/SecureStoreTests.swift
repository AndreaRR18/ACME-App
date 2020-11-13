import XCTest
@testable import SecureStore

final class SecureStoreTests: XCTestCase {
    
    var secureStoreWithGenericPwd: SecureStore!
    
    override func setUp() {
        super.setUp()
        
        let genericPwdQueryable = CredentialSecureStore(service: "ArtooService", accessGroup: nil)
        secureStoreWithGenericPwd = SecureStore(secureStoreQueryable: genericPwdQueryable)
        
    }
    
    override func tearDown() {
        _ = secureStoreWithGenericPwd.removeAllValues()
        
        super.tearDown()
    }
    
    func testSaveGenericPassword() {
        let setValueResult = secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
        
        switch setValueResult {
        case .success:
            XCTAssertTrue(true)
        case let .failure(e):
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testReadGenericPassword() {
        
        guard case .success = secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword") else {
            return XCTFail("Saving generic password failed.")
        }
        
        let passwordResult = secureStoreWithGenericPwd.getValue(for: "genericPassword")
        switch passwordResult {
        case let .success(password):
            XCTAssertEqual("pwd_1234", password)
        case let .failure(e):
            XCTFail("Reading generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testUpdateGenericPassword() {
        
        guard case .success = secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword") else {
            return XCTFail("Saving generic password failed.")
        }
        
        guard case .success = secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword") else {
            return XCTFail("Saving generic password failed.")
        }
        
        let passwordResult = secureStoreWithGenericPwd.getValue(for: "genericPassword")
        switch passwordResult {
        case let .success(password):
            XCTAssertEqual("pwd_1235", password)
        case let .failure(e):
            XCTFail("Updating generic password failed with \(e.localizedDescription).")
        }
        
    }
    
    func testRemoveGenericPassword() {
        
        guard case .success = secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword") else {
            return XCTFail("Saving generic password failed.")
        }
        
        guard case .success = secureStoreWithGenericPwd.removeValue(for: "genericPassword") else {
            return XCTFail("Remove store value failed")
        }
        let sut = secureStoreWithGenericPwd.getValue(for: "genericPassword")
        switch sut {
        case let .success(value):
            XCTAssertNil(value)
        case let .failure(e):
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }
    
    func testRemoveAllGenericPasswords() {
        guard case .success = secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword") else {
            return XCTFail("Saving generic password failed.")
        }
        
        guard case .success = secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword2") else {
            return XCTFail("Saving generic password failed.")
        }
        
        guard case .success = secureStoreWithGenericPwd.removeAllValues() else {
            return XCTFail("Remove all values failed.")
        }
        
        switch secureStoreWithGenericPwd.getValue(for: "genericPassword") {
        case .success(let firstValue):
            switch secureStoreWithGenericPwd.getValue(for: "genericPassword2") {
            case .success(let secondValue):
                XCTAssertNil(firstValue)
                XCTAssertNil(secondValue)
            case let .failure(e):
                XCTFail("Removing generic passwords failed with \(e.localizedDescription).")
            }
        case let .failure(e):
            XCTFail("Removing generic passwords failed with \(e.localizedDescription).")
        }
        
        
    }
    
    static var allTests = [
        ("testSaveGenericPassword", testSaveGenericPassword),
        ("testReadGenericPassword", testReadGenericPassword),
        ("testUpdateGenericPassword", testUpdateGenericPassword),
        ("testRemoveGenericPassword", testRemoveGenericPassword),
        ("testRemoveAllGenericPasswords", testRemoveAllGenericPasswords)
    ]
}



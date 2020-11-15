import XCTest
@testable import Room

final class RoomTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Room().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

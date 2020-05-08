import XCTest
@testable import SwiftFigletKit

final class SwiftFigletKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftFigletKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

import XCTest
@testable import SwiftFigletKit

final class SwiftFigletKitTests: XCTestCase {
    
    func testCreatingACharSetsHeight() {
       
        let sut = SFKChar(charLines: [
            "  #  $@",
            " ##  $@",
            "# #  $@",
            "  #  $@",
            "  #  $@",
            "  #  $@",
            "#####$@"
        ])
        XCTAssertEqual(sut.height, 7)
    }

    static var allTests = [
        ("testCreatingACharSetsHeight", testCreatingACharSetsHeight),
    ]
}

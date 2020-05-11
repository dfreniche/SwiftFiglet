import XCTest
@testable import SwiftFigletKit

final class SFKFigletFileTests: XCTestCase {
    
    func test_Given_Empty_HeaderLine_CreateHeader_Should_Return_Nil() {
       
        let headerLine = ""
        let sut = SFKFigletFile.Header.createFigletFontHeader(from: headerLine)
        XCTAssertNil(sut)
    }
    
    func test_Given_NonEmpty_HeaderLine_CreateHeader_Should_Return_Header() {
       
        let headerLine = "flf2a$ 2 1 8 -1 13"
        let sut = SFKFigletFile.Header.createFigletFontHeader(from: headerLine)
        XCTAssertNotNil(sut)
        XCTAssertEqual("$", sut?.hardBlank)
        XCTAssertEqual(2, sut?.height)
        XCTAssertEqual(1, sut?.baseline)
        XCTAssertEqual(8, sut?.maxLength)
        XCTAssertEqual(-1, sut?.oldLayout)
        XCTAssertEqual(13, sut?.commentLines)
        XCTAssertEqual(SFKFigletFile.PrintDirection.leftToRight, sut?.commentDirection)
    }
    
    func test_Given_NonEmpty_ShortHeaderLine_CreateHeader_Should_Return_Header() {
       
        let headerLine = "flf2a$ 2 1"
        let sut = SFKFigletFile.Header.createFigletFontHeader(from: headerLine)
        XCTAssertNotNil(sut)
        XCTAssertEqual("$", sut?.hardBlank)
        XCTAssertEqual(2, sut?.height)
        XCTAssertEqual(1, sut?.baseline)
        XCTAssertEqual(0, sut?.maxLength)
        XCTAssertEqual(0, sut?.oldLayout)
        XCTAssertEqual(0, sut?.commentLines)
        XCTAssertEqual(SFKFigletFile.PrintDirection.leftToRight, sut?.commentDirection)
    }
    
    func test_Given_File_Should_Load_FigletFont() {
    
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent("Broadway.flf")
        
        let figletFile = SFKFigletFile.from(url: resourceURL)
        
        XCTAssertNotNil(figletFile)
        XCTAssertEqual(29, figletFile?.header.commentLines)
        
        XCTAssertEqual(30, figletFile?.headerLines.count)   // 29 comment lines + 1 line header

        XCTAssertEqual("flf2a$ 11 11 36 2 29", figletFile?.headerLines.first)
        XCTAssertEqual("", figletFile?.headerLines.last)
        XCTAssertEqual("$        $@", figletFile?.lines.first)
    }
}

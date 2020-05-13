//
//  SFKFontTests.swift
//  SwiftFigletKitTests
//
//  Created by Diego Freniche Brito on 10/05/2020.
//

import XCTest
@testable import SwiftFigletKit

final class SFKFontTests: XCTestCase {

    let A = [
    "                      ",
    "         .8.          ",
    "        .888.         ",
    "       :88888.        ",
    "      . `88888.       ",
    "     .8. `88888.      ",
    "    .8`8. `88888.     ",
    "   .8' `8. `88888.    ",
    "  .8'   `8. `88888.   ",
    " .888888888. `88888.  ",
    ".8'       `8. `88888. "
    ]
    func test_Given_FontFile_LoadsFont() {

        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent("testFonts/Broadway.flf")
        
        let font = SFKFont.from(url: resourceURL)
        XCTAssertEqual(font!.height, 11)
        XCTAssertEqual(font!.fkChar["A"]?.lines, A)
    }
    
    func test_Given_FontFile_Font_ContainsFigletFontFile() {

        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent("testFonts/Broadway.flf")
        
        let font = SFKFont.from(url: resourceURL)
        XCTAssertNotNil(font!.figletFile)
        XCTAssertEqual(font!.figletFile?.header.commentLines, 29)
        XCTAssertEqual(font!.figletFile?.header.hardBlank, "$")
    }
}

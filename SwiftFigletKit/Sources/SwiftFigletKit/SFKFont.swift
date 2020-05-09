//
//  SFKFont.swift
//  SwiftFiglet
//
//  Created by Diego Freniche Brito on 08/05/2020.
//  Copyright © 2020 Diego Freniche Brito. All rights reserved.
//

import Foundation

public struct SFKFont {
    
    public var height: Int = 0
    public var fkChar: [Character: SFKChar]

    public init() {
        
        self.fkChar = [Character : SFKChar]()
    }
    
    public mutating func appendChar(for ascii: Character, char: SFKChar) {
                    
        self.fkChar[ascii] = char
        self.height = char.height
    }
}

public extension SFKFont {
    
    static func from(file: String) -> SFKFont {

        func extractHeaderFigletFontInfo(header: String, fileLines: [Substring]) -> (separator: Character, space: Character){
            print(header)
            
            let start = "flf2a"
            
            let headerParts = header.components(separatedBy: " ")
            guard headerParts[0].starts(with: start) else { return (Character(""), Character("")) }
            
            let space = headerParts[0].last ?? "$"
            let commentLines = headerParts[5]
            
            let terminator: Character
            if let lineNumber = Int(commentLines) {
                terminator = fileLines[lineNumber + 1].last ?? "@"
            } else {
                terminator = "@"
            }
            
            return (terminator, space)
        }
        
        var font = SFKFont()

        let dir = FileManager.default.currentDirectoryPath
        let fileURL = URL(fileURLWithPath: dir.appending("/").appending(file))
        do {
            var nextASCIIChar = 32
            let text = try String(contentsOf: fileURL, encoding: .utf8)
            let lines = text.split(separator: "\n")
            var arrayLines: [String] = []
            
            let headerInfo = extractHeaderFigletFontInfo(header: String(lines[0]), fileLines: lines)
            
            for line in lines {
                
                if line.last == headerInfo.separator && line.dropLast().last == headerInfo.separator {
                    
                    let char = SFKChar(charLines: arrayLines)
                    font.appendChar(for: Character(UnicodeScalar(nextASCIIChar) ?? " "), char: char)

                    nextASCIIChar = nextASCIIChar + 1
                    arrayLines = []
                } else if line.last == headerInfo.separator {
                    arrayLines.append(String(line.dropLast().replacingOccurrences(of: String(headerInfo.space), with: " ")))
                }
            }
//            print(text)
        }
        catch {
            
            /* error handling here */
            print(error)
        }
        
        return font
    }
}

//
//  SFKFont.swift
//  SwiftFiglet
//
//  Created by Diego Freniche Brito on 08/05/2020.
//  Copyright © 2020 Diego Freniche Brito. All rights reserved.
//

import Foundation

/// Represents a whole set of Characters, a Figlet Font
public struct SFKFont {
    
    /// height of all Characters in this Font
    public var height: Int = 0
    
    /// all Characters in the font
    /// - new Characters can be added using `appendChar`
    public var fkChar: [Character: SFKChar]

    public init() {
        
        self.fkChar = [Character : SFKChar]()
    }
    
    
    /// Appends a new char to the Font
    /// - Parameters:
    ///   - ascii: the ASCII character to be inserted, for instance "A"
    ///   - char: an instance of `SFKChar` that contains the text-based design of that Character
    /// - called twice for same `ascii` character overwrites previous design
    public mutating func appendChar(for ascii: Character, char: SFKChar) {
                    
        self.fkChar[ascii] = char
        self.height = char.height
    }
}

public extension SFKFont {
    
    /// Loads a Figlet fornt file and returns a fully loaded, ready to use `SFKFont` object
    /// - Parameter file: font file name path including extension
    static func from(file: String) -> SFKFont {

        func extractHeaderFigletFontInfo(header: String, fileLines: [Substring]) -> (separator: Character, space: Character, fontHeight: Int){
            
            /*
             From: http://www.jave.de/docs/figfont.txt
             
             THE HEADER LINE

             The header line gives information about the FIGfont.  Here is an example
             showing the names of all parameters:

                       flf2a$ 6 5 20 15 3 0 143 229    NOTE: The first five characters in
                         |  | | | |  |  | |  |   |     the entire file must be "flf2a".
                        /  /  | | |  |  | |  |   \
               Signature  /  /  | |  |  | |   \   Codetag_Count
                 Hardblank  /  /  |  |  |  \   Full_Layout*
                      Height  /   |  |   \  Print_Direction
                      Baseline   /    \   Comment_Lines
                       Max_Length      Old_Layout*

               * The two layout parameters are closely related and fairly complex.
                   (See "INTERPRETATION OF LAYOUT PARAMETERS".)
             */
            
            print(header)
            
            let start = "flf2a"
            
            let headerParts = header.components(separatedBy: " ")
            guard
                !headerParts.isEmpty,
                headerParts[0].starts(with: start)
            else { return (Character(""), Character(""), 0) }
            
            // last character in start of header "flf2a$" is the hard blank character, in this case $
            let space = headerParts[0].last ?? "$"
            
            // number of comment lines
            let commentLines = headerParts[5]
            
            // line terminator for characters
            let terminator: Character
            if let lineNumber = Int(commentLines) {
                
                terminator = fileLines[lineNumber + 1].last ?? "@"
            } else {
                
                terminator = "@"
            }
            
            // font height
            let fontHeight = Int(headerParts[1]) ?? 0
            
            return (terminator, space, fontHeight)
        }
        
        var font = SFKFont()

        let dir = FileManager.default.currentDirectoryPath
        let fileURL = URL(fileURLWithPath: dir.appending("/").appending(file))
        do {
            
            var nextASCIIChar = 32
            // opening file with ASCII encoding
            let text = try String(contentsOf: fileURL, encoding: .ascii)
            var lines = text.split(separator: "\n")
            if lines.count == 1 {
                lines = text.split(separator: "\r\n")
            }
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
            
            font.height = headerInfo.fontHeight
        } catch {
            
            /* error handling here */
            print(error)
        }
        
        return font
    }
}

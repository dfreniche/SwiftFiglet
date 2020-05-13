//
//  SFKFont.swift
//  SwiftFiglet
/*

MIT - Licence

Copyright (c) 2020 Diego Freniche

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/
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
    
    /// Loads a Figlet font file and returns a fully loaded, ready to use `SFKFont` object
    /// - Parameter url: URL to the font file
    static func from(url: URL) -> SFKFont? {
    
        guard let figletFile = SFKFigletFile.from(url:  url)
        else { return nil }
        
        return from(file: figletFile)
    }
    
    /// Loads a Figlet font file and returns a fully loaded, ready to use `SFKFont` object
    /// - Parameter file: font file name path including extension
    static func from(file: String) -> SFKFont? {
        
        guard let figletFile = SFKFigletFile.from(file: file)
        else { return nil }
        
        return from(file: figletFile)
    }
    
    static func from(file figletFile: SFKFigletFile) -> SFKFont? {
        
        var font = SFKFont()

        font.height = figletFile.header.height

        var nextASCIIChar = 32 // 32 is Space
           
//        let separator = figletFile.characterLineTerminator()
        
        var arrayLines: [String] = []

        for line in figletFile.lines {
            
            let fontLine: Substring
            
            if arrayLines.count < font.height - 1 {

                // remove last @
                fontLine = line.dropLast()
            } else {
            
                // remove last @@
                fontLine = line.dropLast().dropLast()
            }
            arrayLines.append(String(fontLine.replacingOccurrences(of: String(figletFile.header.hardBlank), with: " ")))
            
            // last line
            if arrayLines.count == font.height {
                                
                let char = SFKChar(charLines: arrayLines)
                font.appendChar(for: Character(UnicodeScalar(nextASCIIChar) ?? " "), char: char)

                nextASCIIChar = nextASCIIChar + 1
                arrayLines = []
            }
        }
        
        return font
    }
}

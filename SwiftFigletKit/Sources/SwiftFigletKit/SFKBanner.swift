//
//  String+SFKFont.swift
//  SwiftFigletKit
//
/*

MIT - Licence

Copyright (c) 2020 Diego Freniche

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

import Foundation
import Swift


/// Makes easy to print text banner messages using a SFKFigletFont
public struct SFKBanner {
   
    public static func print(string: String, withFigletFont font: SFKFont) {
        
        guard font.height > 0 else { return }
        
        for i in 0...font.height - 1 {
            for c in string {
                
                if let fontCharacter = font.fkChar[c],
                   i < fontCharacter.lines.count {
                    
                    Swift.print(fontCharacter.lines[i], separator: "", terminator: "")
                } else {
                    
                    // Swift.print("\(c)")
                }
            }
            Swift.print("")
        }
    }
}

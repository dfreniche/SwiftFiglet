//
//  SFKChar.swift
//  SwiftFiglet
/*

MIT - Licence

Copyright (c) 2020 Diego Freniche

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

import Foundation

/// Represents a single big, banner-like character
/// - A Character is a bidimensional array of ASCII chars
/// - something like:
/// ```
///  #  $@
/// ##  $@
///# #  $@
///  #  $@
///  #  $@
///  #  $@
/// #####$@
/// ```
public struct SFKChar {
    
    /// Represents an empty Character
    public static let EmptyChar = SFKChar(charLines: [])
    
    /// height in lines of this Character
    public let height: Int
    
    /// lines, from top to bottom that made up this Character
    public var lines: [String] { _lines }
    
    private var _lines: [String]
    
    public init(charLines: [String]) {
        
        self._lines = charLines
        self.height = charLines.count
    }
}

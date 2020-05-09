//
//  SFKChar.swift
//  SwiftFiglet
//
//  Created by Diego Freniche Brito on 08/05/2020.
//  Copyright © 2020 Diego Freniche Brito. All rights reserved.
//

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

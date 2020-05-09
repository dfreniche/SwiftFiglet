//
//  SFKChar.swift
//  SwiftFiglet
//
//  Created by Diego Freniche Brito on 08/05/2020.
//  Copyright © 2020 Diego Freniche Brito. All rights reserved.
//

import Foundation

public struct SFKChar {
    
    public static let EmptyChar = SFKChar(charLines: [])
    
    public let height: Int
    public var lines: [String] { _lines }
    
    private var _lines: [String]
    
    public init(charLines: [String]) {
        
        self._lines = charLines
        self.height = charLines.count
    }
}

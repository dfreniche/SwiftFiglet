//
//  String+FKFont.swift
//  SwiftFigletKit
//
//  Created by Diego Freniche Brito on 08/05/2020.
//

import Foundation

public extension String {
   
    func printWithFont(font: FKFont) {
        
        for c in self {
            print("\(c)")
        }
    }
}

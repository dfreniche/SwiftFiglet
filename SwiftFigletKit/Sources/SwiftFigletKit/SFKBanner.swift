//
//  String+SFKFont.swift
//  SwiftFigletKit
//
//  Created by Diego Freniche Brito on 08/05/2020.
//

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

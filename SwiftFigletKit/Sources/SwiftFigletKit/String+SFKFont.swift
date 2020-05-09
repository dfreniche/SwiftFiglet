//
//  String+SFKFont.swift
//  SwiftFigletKit
//
//  Created by Diego Freniche Brito on 08/05/2020.
//

import Foundation
import Swift

public extension String {
   
    func print(withFigletFont font: SFKFont) {
        
        guard font.height > 0 else { return }
        
        for i in 0...font.height - 1 {
            for c in self {
                
                if let fontCharacter = font.fkChar[c] {
                    
                    Swift.print(fontCharacter.lines[i], separator: "", terminator: "")
                } else {
                    
//                    Swift.print("\(c)")
                }
            }
            Swift.print("")
        }
    }
}

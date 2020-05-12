//
//  main.swift
//  SwiftFiglet
//
//  Created by Diego Freniche Brito on 08/05/2020.
//  Copyright © 2020 Diego Freniche Brito. All rights reserved.
//

import Foundation
import SwiftFigletKit
import Files

//print("Hello, World!".printWithFont(font: FKFont()))

if let font = SFKFont.from(file: "fonts/starwars.flf") {
    
    Banner.print(string: "this", withFigletFont: font)
}


if let computerFont = SFKFont.from(file: "fonts/Big-Money-ne.flf") {
    
    Banner.print(string: "Hello", withFigletFont: computerFont)
    Banner.print(string: "World", withFigletFont: computerFont)
}


try Folder(path: "fonts").files.enumerated().forEach { (index, file) in
    print("* index: \(index) file: \(file.name)")
    
    if let font = SFKFont.from(file: "fonts/" + file.name) {
        
        Banner.print(string: "ABCDE-012345", withFigletFont: font)
    }
}

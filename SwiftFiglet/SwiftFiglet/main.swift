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

// We can load a Figlet Font just passing in file name
if let font = SFKFont.from(file: "fonts/Banner.flf") {
    
    // Then we can print using that font
    print(string: "Swift Figlet Kit", usingFont: font)
}

// we'll print "Swift Figlet Kit" using each font in the `fonts` directory
try Folder(path: "fonts").files.enumerated().forEach { (index, file) in

    print("* index: \(index) file: \(file.name)")

    if let font = SFKFont.from(file: "fonts/" + file.name) {

        print(string: "Swift Figlet Kit", usingFont: font)
    }
}

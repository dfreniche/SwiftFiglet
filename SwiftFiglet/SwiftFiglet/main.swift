//
//  main.swift
//  SwiftFiglet
//
//  Created by Diego Freniche Brito on 08/05/2020.
//  Copyright © 2020 Diego Freniche Brito. All rights reserved.
//

import Foundation
import SwiftFigletKit

//print("Hello, World!".printWithFont(font: FKFont()))

let font = SFKFont.from(file: "fonts/starwars.flf")

//let a = [
//"     ___  $   ",
//"    /   \\ $   ",
//"   /  ^  \\$   ",
//"  /  /_\\  \\$  ",
//" /  _____  \\$ ",
//"/__/     \\__\\$",
//"             $"]
//font.appendChar(for: "a", char: SFKChar(charLines: a))
"this".print(withFigletFont: font)
"is".print(withFigletFont: font)
"magic".print(withFigletFont: font)

let computerFont = SFKFont.from(file: "fonts/Big-Money-ne.flf")


"LA".print(withFigletFont: computerFont)
"GAFAS".print(withFigletFont: computerFont)

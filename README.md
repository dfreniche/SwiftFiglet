# SwiftFigletKit

```
  #####                                 #######                                        #    #           
 #     #  #    #  #  ######  #####      #        #   ####   #       ######  #####      #   #   #  ##### 
 #        #    #  #  #         #        #        #  #    #  #       #         #        #  #    #    #   
  #####   #    #  #  #####     #        #####    #  #       #       #####     #        ###     #    #   
       #  # ## #  #  #         #        #        #  #  ###  #       #         #        #  #    #    #   
 #     #  ##  ##  #  #         #        #        #  #    #  #       #         #        #   #   #    #   
  #####   #    #  #  #         #        #        #   ####   ######  ######    #        #    #  #    #   
```

A simple library to read and display [banner](https://en.wikipedia.org/wiki/Banner_(Unix)) like ASCII art messages using [Figlet](http://www.figlet.org/) fonts 

## Installation

- Add FigletKit to your project using Swift Package Manager. From Xcode add this repo as a package.
- Or clone this repo and copy over the required four files: `SFKFont`, `SFKChar`, `SFKBanner` and `SFKFigletFile`

## Limitations

- this is a macOS library, for CLI programs. Can be adapted for iOS.
- Only Figlet font files are supported (.flf)
- If you have trouble loading a flf file, open an issue and attach font file, please.

## How to Use

- Load a `SFKFont` with

```swift

import SwiftFigletKit
 
let font = SFKFont.from(file: "fonts/starwars.flf")
```

- Once loaded, you can start printing to the console using

```swift
print(string: "Swift Figlet Kit", usingFont: font)
```

- No step 3. Told you it was a simple library 😅

## TODO

- [x] Finish this README 😅
- [x] add MIT license notice
- [x] Add Swift Figlet File property as optional after loading a `SFKFont` from disk
- [x] Remove [Toilet fonts](http://caca.zoy.org/wiki/toilet) from fonts sample dir: won't support them
- [ ] Add support for lines adding Unicode character to be loaded, like  `196  LATIN CAPITAL LETTER A WITH DIAERESIS`, see Banner.flf
- [x] test font `Wow.flf` with mixed line endings (`CR/LF` and `CR`)
- [ ] adapt file loading for iOS
- [ ] honor right to left print direction 


## Fonts used

I've used the Figlet fonts from [xero's](https://github.com/xero/figlet-fonts) repo

## License

MIT

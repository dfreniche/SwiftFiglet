# SwiftFigletKit

A library to read and display banner like ASCII art messages using [Figlet](http://www.figlet.org/) fonts 

## Installation

- Add to your project using Swift Package Manager. From Xcode add this repo as a package
- Or clone this repo and copy over the required three files: `SFKFont`, `SFKChar` and `String+SFKFont`

## Use

Load a `SFKFont` with

```swift
let font = SFKFont.from(file: "fonts/starwars.flf")
```

Once loaded, 

## TODO

- [ ] Finish this README 😅
- [ ] Add Swift Figlet File property as optional after loading a `SFKFont` from disk
- [  ] Add support for lines adding Unicode character to be loaded, like  `196  LATIN CAPITAL LETTER A WITH DIAERESIS`, see Banner.flf
- [x] test font Wow.flf with mixed line endings (`CR/LF` and `CR`)


## Fonts

I've used the Figlet fonts from [xero's](https://github.com/xero/figlet-fonts) repo

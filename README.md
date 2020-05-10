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

## Fonts

I've used the Figlet fonts from [xero's](https://github.com/xero/figlet-fonts) repo

//
//  SFKFigletFile.swift
//  SwiftFigletKit
//
//  Created by Diego Freniche Brito on 10/05/2020.
//

import Foundation

public struct SFKFigletFile {
    
    private enum CRLF: Character {
        
        case WindowsStyle = "\r\n"
        case UnixStyle = "\n"
    }
    
    public enum PrintDirection: Int {
        
        case leftToRight = 0
        case rightToLeft = 1
    }
    
    /**
     Figlet file header
    
     ```
     From: http://www.jave.de/docs/figfont.txt
     
     THE HEADER LINE

     The header line gives information about the FIGfont.  Here is an example
     showing the names of all parameters:

               flf2a$ 6 5 20 15 3 0 143 229    NOTE: The first five characters in
                 |  | | | |  |  | |  |   |     the entire file must be "flf2a".
                /  /  | | |  |  | |  |   \
       Signature  /  /  | |  |  | |   \   Codetag_Count
         Hardblank  /  /  |  |  |  \   Full_Layout*
              Height  /   |  |   \  Print_Direction
              Baseline   /    \   Comment_Lines
               Max_Length      Old_Layout*

       * The two layout parameters are closely related and fairly complex.
           (See "INTERPRETATION OF LAYOUT PARAMETERS".)
     ```
    */
    public struct Header {
        
        private static let headerStartSignature = "flf2a"
        
        public let hardBlank: String
        public let height: Int
        public let baseline: Int
        public let maxLength: Int
        public let oldLayout: Int
        public let commentLines: Int
        public let commentDirection: PrintDirection
        public let fullLayout: Int
        public let codeTagCount: Int
        
        
        /// Returns a Header from String passed. If can't create it bacause `from` does not follow Figlet header format, returns `nil`
        /// - Parameter header: first line from a Figlet font file
        public static func createFigletFontHeader(from header: String) -> Header? {
            
            print(header)
            
            let headerParts = header.components(separatedBy: " ")
            guard
                !headerParts.isEmpty,
                let signature = headerParts.first,
                signature.starts(with: Header.headerStartSignature)
            else { return nil }
            
            // last character in signature (start of header "flf2a$") is the hard blank character, in this case $
            let hardBlank = String(signature.last ?? "$")
            
            // font height
            let fontHeight = Int(headerParts[safe: 1] ?? "0") ?? 0
            let baseLine = Int(headerParts[safe: 2] ?? "0") ?? 0
            let maxLength = Int(headerParts[safe: 3] ?? "0") ?? 0
            let oldLayout = Int(headerParts[safe: 4] ?? "0") ?? 0
            let commentLines = Int(headerParts[safe: 5] ?? "0") ?? 0
            let commentDirection = PrintDirection(rawValue: Int(headerParts[safe: 6] ?? "0") ?? 0) ?? PrintDirection.leftToRight
            let fullLayout = Int(headerParts[safe: 7] ?? "0") ?? 0
            let codeTagCount = Int(headerParts[safe: 8] ?? "0") ?? 0

            return Header(hardBlank: hardBlank,
                          height: fontHeight,
                          baseline: baseLine,
                          maxLength: maxLength,
                          oldLayout: oldLayout,
                          commentLines: commentLines,
                          commentDirection: commentDirection,
                          fullLayout: fullLayout,
                          codeTagCount: codeTagCount)
        }
    }
    
    /// `Header` info for this font, @see `Header`
    public let header: Header
    public let headerLines: [Substring]
    public let lines: [Substring]
    
    /// Returns line terminator for characters, usually `@` or `#`
    public func characterLineTerminator() -> Character {
        
        // line terminator for characters
        let terminator: Character = lines[header.commentLines].last ?? "@"
        
        return terminator
    }
    
    /// Loads a Figlet file `.flf` from disc
    /// - Parameter file: file name
    /// - Returns: a`SFKFigletFile` object containing the file or `nil` if there was an error
    public static func from(file: String) -> SFKFigletFile? {
        
        let dir = FileManager.default.currentDirectoryPath
        let fileURL = URL(fileURLWithPath: dir.appending("/").appending(file))
        
        return from(url: fileURL)
    }
    
    /// Loads a Figlet file `.flf` from disc
    /// - Parameter fileURL: URL pointing to the file.
    /// - Returns: a`SFKFigletFile` object containing the file or `nil` if there was an error
    public static func from(url fileURL: URL) -> SFKFigletFile? {
        
        do {
            // opening file with ASCII encoding, Figlet files are ASCII files
            let text = try String(contentsOf: fileURL, encoding: .ascii)
            
            // we try to split file in lines using line terminator Unix Style
            // omittingEmptySubsequences is `false` to not lose empty lines added
            // as vertical spaces
            var lines = text.split(separator: CRLF.UnixStyle.rawValue, omittingEmptySubsequences: false)
            if lines.count == 1 {
                
                // if this fails we try Windows line terminator style
                lines = text.split(separator: CRLF.WindowsStyle.rawValue, omittingEmptySubsequences: false)
            }
            
            if let header = Header.createFigletFontHeader(from: String(lines.first ?? "")) {
            
                var headerLines: [Substring] = []
                for i in 0...header.commentLines {
                    
                    headerLines.append(lines[i])
                }
                
                // lines describing characters start after: 1 line header + header.commentLines
                let characterLines = lines.dropFirst(header.commentLines + 1).map { $0 }
                return SFKFigletFile(header: header, headerLines: headerLines, lines: characterLines)
            } else {
                
                // can't extract header
                return nil
            }
        } catch {
            
            // errors opening file
            return nil
        }
    }
}

extension Collection where Indices.Iterator.Element == Index {
    
    subscript (safe index: Index) -> Iterator.Element? {
        
        return indices.contains(index) ? self[index] : nil
    }
}

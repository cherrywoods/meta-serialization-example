//
//  TschuhTschuh.swift
//  Examples
//
//  Created by cherrywoods on 22.01.18.
//

import Foundation

struct TrainFormat {
    
    // an example: 🚂["name": "fernando", "age": "45", "array": -1>]¬[1.: "first", 2.: "second", 3.: "third"]
    
    // the following is the encoding
    // of a single directly encodable value
    // further example: 🚂["7.998"]
    
    static let locomotive = "🚂"
    static let wagonBeginning = "["
    static let keyValueSeparator = ": "
    static let elementsSeparator = ", "
    static let wagonEnding = "]"
    static let wagonConnector = "¬"
    
    static func reference(to relative: Int) -> String {
        return "-\(relative)>"
    }
    
    static func relativeIndex(from reference: String) -> Int? {
        
        if reference.first == "-" && reference.last == ">" {
            
            return Int(String( reference.dropFirst().dropLast() ))
            
        } else {
            return nil
        }
        
    }
    
}

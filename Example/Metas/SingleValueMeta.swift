//
//  SingleValueMeta.swift
//  Examples
//
//  Created by cherrywoods on 22.01.18.
//

import Foundation
import MetaSerialization

struct SingleValueMeta: Meta {
    
    static let nilMeta = SingleValueMeta(string: "nil")
    
    var string: String = ""
    
    init() {  }
    
    init(string: String) {
        self.string = string
    }
    
    mutating func set(value: Any) throws {
        
        // this check isn't required, but good to have
        // a failure indicates an error in this project or in MetaSerialization
        precondition(value is LosslessStringConvertible, "Invalid type on set")
        
        self.string = (value as! LosslessStringConvertible).description
        
    }
    
    func get() -> Any? {
        return string
    }
    
}

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
    
    init(string: String) {
        self.string = string
    }
    
    init(value: Any) {
        
        self.string = (value as! LosslessStringConvertible).description
        
    }
    
}

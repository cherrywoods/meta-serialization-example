//
//  Genie.swift
//  Flaschengeist
//  
//  Copyright 2018 cherrywoods
//
//  Available at the terms of the LICENSE file included in this project.
//  If none is included, available at the terms of the CC0 license. 
//  See https://creativecommons.org/publicdomain/zero/1.0/legalcode.
// 

import Foundation
import MetaSerialization

struct Genie :CustomStringConvertible {
    
    var description: String
    init() {
        self.description = someInt() < 128 ? " 🧞‍♀️ " : " 🧞‍♂️ "
    }
    
    func decode<D: Decodable>(lamp: String, to type: D.Type) throws -> D {
        
        guard let meta = LampMeta(lamp) else {
            throw GenieError.noGenieInsideThisLamp
        }
        
        // reset wish counter
        wishCount = 3
        
        print("Starting to decode newly created meta: \(meta).")
        print(" ** I grant you three wishes ** ")
        
        return try MetaDecoder(unwrapper: GenieUnwrapper()).decode(type: type, from: meta)
        
    }
    
}

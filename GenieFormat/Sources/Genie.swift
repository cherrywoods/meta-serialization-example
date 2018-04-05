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

struct Genie {
    
    func decode<D: Decodable>(lamp: String, to type: D.Type) throws -> D {
        
        guard let meta = LampMeta(lamp) else {
            throw GenieError.noGenieInsideThisLamp
        }
        
        // reset wish counter
        wishCount = 3
        
        return try MetaDecoder(unwrapper: GenieUnwrapper()).decode(type: type, from: meta)
        
    }
    
}

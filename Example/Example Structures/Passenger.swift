//
//  Passenger.swift
//  Examples
//
//  Created by cherrywoods on 22.01.18.
//

/*
 
 This struct is just here for demonstration purposes.
 It has no real meaning
 
 */

import Foundation
import MetaSerialization

struct Passenger: DirectlyCodable, LosslessStringConvertible {
    
    /*
     This struct implements DirectlyCodable
     which means nothing else, that that
     the Translator supports it directly,
     it's a 'primitive' type.
     */
    
    let happy: Bool
    
    init?(_ description: String = "😄") {
        
        guard description == "😄" || description == "😞" else {
            return nil
        }
        
        self.happy = description == "😄"
        
    }
    
    var description: String {
        return happy ? "😄" : "😞"
    }
    
}

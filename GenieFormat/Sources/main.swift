//
//  main.swift
//  Flaschengeist
//  
//  Copyright 2018 cherrywoods
//
//  Available at the terms of the LICENSE file included in this project.
//  If none is included, available at the terms of the CC0 license. 
//  See https://creativecommons.org/publicdomain/zero/1.0/legalcode.
// 

// for simplicity this example has only a decoding capability
// it decodes from 🔦 to three arbitrary types (as long as it's String, Int or Double)

import Foundation

let lamp = "🔦"

struct ThreeWishes: Decodable {
    
    init(from decoder: Decoder) throws {
        
        var container = try decoder.unkeyedContainer()
        
        // I wish a String
        let string = try container.decode(String.self)
        // I wish an Int
        let int = try container.decode(Int.self)
        // And I wish a nil
        let isNil = try container.decodeNil()
        
        print("My three wishes: A String: \"\(string)\", an Int: \(int) and nil. \( isNil ? "And I got nil" : "But I didn't got nil." ).")
        
    }
    
}

_ = try Genie().decode(lamp: lamp, to: ThreeWishes.self)

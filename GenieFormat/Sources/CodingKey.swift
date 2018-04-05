//
//  CodingKey.swift
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

enum GenieCodingKey: CodingKey {
    
    static var keysDependingOnWishCount: [GenieCodingKey] {
        
        var keys: [GenieCodingKey] = []
        switch wishCount {
        case 3:
            keys.append(.firstWish)
            fallthrough
        case 2:
            keys.append(.secondWish)
            fallthrough
        case 1:
            keys.append(.thirdWish)
        case 0:
            keys += []
        default:
            preconditionFailure("You have three wishes, not more, not less, don't try to manipulate the genie.")
        }
        
        return keys
        
    }
    
    case firstWish
    case secondWish
    case thirdWish
    
}

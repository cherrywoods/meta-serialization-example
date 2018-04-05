//
//  Unwrapper.swift
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

/// the genies global wish count 
var wishCount = 3

class GenieUnwrapper: Unwrapper {
    
    // this is the "normal" unwrap method,
    // here, we unwrap to concreate types
    func unwrap<T>(meta: Meta, toType type: T.Type, for decoder: MetaDecoder) throws -> T? where T : Decodable {
        
        guard wishCount > 0 else {
            throw GenieError.noWishesLeft
        }
        
        print("Requesting type: \(type) for meta: \(meta).")
        
        // this format just supports Strings, Ints and Doubles for shortness
    
        switch type {
        case is String.Type:
            wishCount -= 1
            return someString() as? T
        case is Int.Type:
            wishCount -= 1
            return someInt() as? T
        case is Double.Type:
            wishCount -= 1
            return someDouble() as? T
        default:
            return nil
        }
        
    }
    
    // MARK: dynamic meta tree unwinding
    // this is the additional section
    // these three methods allow us to create new metas
    // when they are needed depending on the container that's requested (also nil values)
    
    func unwrap(meta: Meta, toType: NilMeta.Protocol, for decoder: MetaDecoder) -> NilMeta? {
        
        print("Requesting nil for meta: \(meta)")
        
        // nil is an easy wish :)
        // (but it's also a wish)
        wishCount -= 1
        
        return NilMarker.instance
        
    }
    
    func unwrap(meta: Meta, toType: DecodingKeyedContainerMeta.Protocol, for decoder: MetaDecoder) throws -> DecodingKeyedContainerMeta? {
        
        print("Requesting keyed container for meta: \(meta)")
        
        return GenieContainerMeta()
        
    }
    
    func unwrap(meta: Meta, toType: DecodingUnkeyedContainerMeta.Protocol, for decoder: MetaDecoder) throws -> DecodingUnkeyedContainerMeta? {
        
        print("Requesting unkeyed container for meta: \(meta)")
        
        return GenieContainerMeta()
        
    }
    
}

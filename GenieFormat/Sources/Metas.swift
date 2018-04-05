//
//  Meta.swift
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

struct LampMeta: Meta, CustomStringConvertible {
    
    init?(_ lamp: String) {
        
        guard lamp == "🔦" else {
            return nil
        }
        
    }
    
    init() {}
    
    var description: String {
        
        return "A lamp meta"
        
    }
    
}

struct GenieNilMeta: NilMeta, CustomStringConvertible {
    
    var description: String {
        
        return "A genie nil meta"
        
    }
    
}

struct GenieContainerMeta: DecodingKeyedContainerMeta, DecodingUnkeyedContainerMeta, CustomStringConvertible {
    
    var description: String {
        
        return "A genie container meta"
        
    }
    
    // MARK: keyed
    
    var allKeys: [MetaCodingKey] {
        
        return GenieCodingKey.keysDependingOnWishCount.map { MetaCodingKey(codingKey: $0) }
        
    }
    
    func contains(key: MetaCodingKey) -> Bool {
        
        return true
        
    }
    
    func getValue(for key: MetaCodingKey) -> Meta? {
        
        return LampMeta()
        
    }
    
    // MARK: unkeyed
    
    var numberOfMetasIfKnown: Int? {
        return wishCount
    }
    
    func get(at index: Int) -> Meta? {
        
        return LampMeta()
        
    }
    
}

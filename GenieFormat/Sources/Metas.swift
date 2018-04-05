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
    
    // used to identify metas
    static var counter = 0
    private let id: Int
    
    init?(_ lamp: String) {
        
        guard lamp == "🔦" else {
            return nil
        }
        
        self.init()
        
    }
    
    init() {
        self.id = LampMeta.counter
        LampMeta.counter += 1
    }
    
    var description: String {
        
        return "LampMeta nr. \(id)"
        
    }
    
}

struct GenieNilMeta: NilMeta, CustomStringConvertible {
    
    static var counter = 0
    private let id: Int
    
    init() {
        self.id = GenieNilMeta.counter
        GenieNilMeta.counter += 1
    }
    
    var description: String {
        
        return "GenieNilMeta nr. \(id)"
        
    }
    
}

struct GenieContainerMeta: DecodingKeyedContainerMeta, DecodingUnkeyedContainerMeta, CustomStringConvertible {
    
    static var counter = 0
    private let id: Int
    
    init() {
        self.id = GenieContainerMeta.counter
        GenieContainerMeta.counter += 1
    }
    
    var description: String {
        
        return "GenieContainerMeta nr. \(id)"
        
    }
    
    // MARK: keyed
    
    var allKeys: [MetaCodingKey] {
        
        return GenieCodingKey.keysDependingOnWishCount.map { MetaCodingKey(codingKey: $0) }
        
    }
    
    func contains(key: MetaCodingKey) -> Bool {
        
        return true
        
    }
    
    func getValue(for key: MetaCodingKey) -> Meta? {
        
        print("Requesting meta for key: \(key) from meta: \(self)")
        return LampMeta()
        
    }
    
    // MARK: unkeyed
    
    var numberOfMetasIfKnown: Int? {
        return wishCount
    }
    
    func get(at index: Int) -> Meta? {
        
        print("Requesting meta at index: \(index) from meta: \(self)")
        return LampMeta()
        
    }
    
}

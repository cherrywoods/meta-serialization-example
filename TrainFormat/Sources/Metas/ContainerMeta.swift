//
//  ContainerMeta.swift
//  Examples
//
//  Created by cherrywoods on 22.01.18.
//

import Foundation
import MetaSerialization

/**
 This Meta unifies the abilities of keyed and unkeyed container metas,
 because there's no difference in the serialization format.
 
 The Meta is used for encoding and decoding.
 
 During decoding, there is a check performed whether this meta can be seen as an unkeyed container.
 If can't be seen as one, it will return 0 for count and nil for all calls of get.
 This surely isn't the optimal behavior. A more elegant way to solve this would be to use
 dynamic meta tree unwinding.
 See the other example, GenieFormat for it's usage, or the documentation of `Unwrapper`.
 */
class ContainerMeta: KeyedContainerMeta, UnkeyedContainerMeta {
    
    /**
     Stores the keys and values passed to this meta.
     For unkeyed behavior, we use keys like "1.", "2.",...
     */
    var subMetas = Dictionary<String, Meta>()
    
    // this is the encoding initalizer
    init() {
        // it plays no rule during encoding whther it is decodable as unkeyed container.
        self.isUnkeyedContainer = true
    }
    
    // this is the decoding initalizer
    init(subMetas: Dictionary<String,Meta>) {
        self.subMetas = subMetas
        
        var isValidUnkeyedContainer = true
        // check whether subMetas contains the right keys to be an unkeyed container
        for index in (0..<subMetas.count) {
            
            guard subMetas[ ContainerMeta.convertToKey(index: index) ] != nil else {
                isValidUnkeyedContainer = false
                break
            }
            
        }
        
        self.isUnkeyedContainer = isValidUnkeyedContainer
        
    }
    
    // MARK: - keyed
    
    var allKeys: [MetaCodingKey] {
        
        // the stringValues should fully identify the CodingKeys
        return subMetas.keys.map { MetaCodingKey(stringValue: $0) }
        
    }
    
    func put(_ value: Meta, for key: MetaCodingKey) {
        
        subMetas[key.stringValue] = value
        
    }
    
    func getValue(for key: MetaCodingKey) -> Meta? {
        
        return subMetas[key.stringValue]
        
    }
    
    
    func contains(key: MetaCodingKey) -> Bool {
        
        return subMetas[key.stringValue] != nil
        
    }
    
    // MARK: - unkeyed
    
    /// Whether or not this contaiener is a valid unkeyed container. Default is true, because it plays no role during encoding.
    let isUnkeyedContainer: Bool
    var numberOfMetas: Int {
        
        guard isUnkeyedContainer else {
            return 0
        }
        
        return subMetas.count
        
    }
    
    func get(at index: Int) -> Meta? {
        
        return subMetas[ ContainerMeta.convertToKey(index: index) ]
        
    }
    
    func insert(_ meta: Meta, at index: Int) {
        
        subMetas[ ContainerMeta.convertToKey(index: index) ] = meta
        
    }
    
    static func convertToKey(index: Int) -> String {
        return "\(index)."
    }
    
}

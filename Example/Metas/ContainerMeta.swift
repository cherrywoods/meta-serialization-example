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
 
 The Meta is used for encoding and decoding
 */
class ContainerMeta: KeyedContainerMeta, UnkeyedContainerMeta {
    
    /**
     Stores the keys and values passed to this meta.
     For unkeyed behavior, use keys like "1.", "2.",...
     */
    var subMetas = Dictionary<String, Meta>()
    
    init() {}
    
    init(subMetas: Dictionary<String,Meta>) {
        self.subMetas = subMetas
    }
    
    // MARK: - keyed
    
    subscript(key: CodingKey) -> Meta? {
        
        get {
            return subMetas[key.stringValue]
        }
        
        set(newValue) {
            subMetas[key.stringValue] = newValue
        }
        
    }
    
    func allKeys<Key>() -> [Key] where Key : CodingKey {
        
        // the stringValues should fully identify the CodingKeys
        return subMetas.keys.flatMap { return Key(stringValue: $0) }
        
    }
    
    func contains(key: CodingKey) -> Bool {
        
        return subMetas[key.stringValue] != nil
        
    }
    
    // MARK: - unkeyed
    
    var count: Int? {
        return subMetas.count
    }
    
    func get(at index: Int) -> Meta? {
        return subMetas[convertToKey(index: index)]
    }
    
    func insert(element: Meta, at index: Int) {
        subMetas[convertToKey(index: index)] = element
    }
    
    func append(element: Meta) {
        // note that indexing starts at 0 in UnkeyedContainerMetas
        subMetas[convertToKey(index: count!)] = element
    }
    
    func convertToKey(index: Int) -> String {
        return "\(index)."
    }
    
    // MARK: - meta in general
    
    func set(value: Any) throws {
        // see SingleValueMeta
        precondition(value is Dictionary<String, Meta>, "Invalid type on set. Dictionary<String, Meta> is required.")
    }
    
    func get() -> Any? {
        return subMetas
    }
    
}

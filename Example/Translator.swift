//
//  Translator.swift
//  Examples
//
//  Created by cherrywoods on 22.01.18.
//

import Foundation
import MetaSerialization

class 🚂Translator: MetaSerialization.Translator {
    
    // MARK: - encoding
    
    func wrappingMeta<T>(for value: T) -> Meta? {
        
        /*
         In this function we define which types
         we support directly and which need to encode themselves.
         These 'primitive' types are the types
         that we can represent in our serialization format.
         In this case: String, Bool, all Ints, Float, Double,
         and the type Passenger.
         
         Returning nil means that we do not support a type.
         */
        
        if value is String ||
            value is Bool ||
            value is Int || value is Int8 || value is Int16 || value is Int32 || value is Int64 ||
            value is UInt || value is UInt8 || value is UInt16 || value is UInt32 || value is UInt64 ||
            value is Float || value is Double ||
            value is Passenger {
            
            // we use a single Meta type for all those types
            return SingleValueMeta()
            
        } else if value is GenericNil {
            
            // support nil values
            return SingleValueMeta.nilMeta
            
        } else {
            
            // all other types are not directly supported
            return nil
            
        }
        
    }
    
    /*
     We use one Meta type for both keyed and unkeyed
     behaviors here because or final serialization format
     has no unkeyed containers.
     For this reason we use keyed containers for both purposes.
     */
    
    func keyedContainerMeta() -> KeyedContainerMeta {
        return ContainerMeta()
    }
    
    func unkeyedContainerMeta() -> UnkeyedContainerMeta {
        return ContainerMeta()
    }
    
    func encode<Raw>(_ meta: Meta) throws -> Raw {
        
        // encoding code is outsources to TrainFormat
        // it is totally legitimate to force cast to Raw
        // because the Raw format is set by ourselves
        // in our implementation of Representation or
        // Serialization.
        return TrainFormat.encode(meta: meta) as! Raw
        
    }
    
    // MARK: - decoding
    
    func unwrap<T>(meta: Meta) throws -> T? {
        
        guard let stringValue = (meta as? SingleValueMeta)?.string else {
            return nil
        }
        
        /*
         This is the decoding counterpart to wrap(for:)
         But in difference to this method, we have no
         value, so we can't use is. This means we can't
         handle subclasses, etc.
         In this case this isn't that critical, but
         when writing a real Translator this is a real limitation.
         It does for example makes it impossible to use all types
         implementing LosslessStringCOnvertible as primitive types.
         */
        
        if T.self == String.self {
            return stringValue as? T
            
        } else if T.self == Bool.self {
            return Bool(stringValue) as? T
            
        } else if T.self == Int.self {
            return Int(stringValue) as? T
        } else if T.self == UInt.self {
            return UInt(stringValue) as? T
        } else if T.self == Int8.self {
            return Int8(stringValue) as? T
        } else if T.self == UInt8.self {
            return UInt8(stringValue) as? T
        } else if T.self == Int16.self {
            return Int16(stringValue) as? T
        } else if T.self == UInt16.self {
            return UInt16(stringValue) as? T
        } else if T.self == Int32.self {
            return Int32(stringValue) as? T
        } else if T.self == UInt32.self {
            return UInt32(stringValue) as? T
        } else if T.self == Int64.self {
            return Int64(stringValue) as? T
        } else if T.self == UInt64.self {
            return UInt64(stringValue) as? T
            
        } else if T.self == Float.self {
            return Float(stringValue) as? T
        } else if T.self == Double.self {
            return Double(stringValue) as? T
            
        } else if T.self == Passenger.self {
            return Passenger(stringValue) as? T
            
        } else {
            return nil
        }
        
    }
    
    func decode<Raw>(_ raw: Raw) throws -> Meta {
        // the same as for encode() applies here
        return TrainFormat.decode(from: raw as! String)
    }
    
}

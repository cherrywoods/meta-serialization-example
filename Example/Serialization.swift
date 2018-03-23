//
//  Serialization.swift
//  Examples
//
//  Created by cherrywoods on 29.01.18.
//

import Foundation
import MetaSerialization

class 🚂Serialization: Serialization {
    
    typealias Raw = String
    
    private static let translator = 🚂Translator()
    
    func provideNewEncoder() -> MetaEncoder {
        return MetaEncoder(metaSupplier: 🚂Serialization.translator, storage: CodingDictionary())
    }
    
    func provideNewDecoder() -> MetaDecoder {
        return MetaDecoder(unwrapper: 🚂Serialization.translator, storage: CodingDictionary())
    }
    
    func convert(raw: String) throws -> Meta {
        
        return TrainFormat.decode(from: raw)
        
    }
    
    func convert(meta: Meta) throws -> String {
        
        return TrainFormat.encode(meta: meta)
        
    }
    
    
}

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
    
    func provideNewEncoder() -> MetaEncoder {
        return MetaEncoder(translator: 🚂Translator())
    }
    
    func provideNewDecoder(raw: String) throws -> MetaDecoder {
        return try MetaDecoder(translator: 🚂Translator(), raw: raw)
    }
    
}

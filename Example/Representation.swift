//
//  Representation.swift
//  Examples
//
//  Created by cherrywoods on 29.01.18.
//

import Foundation
import MetaSerialization

protocol 🚂: Representation {  }

extension String: 🚂 {  }

extension 🚂 {
    
    public static func provideNewEncoder() -> MetaEncoder {
        return MetaEncoder(translator: 🚂Translator())
    }
    
    public func provideNewDecoder() throws -> MetaDecoder {
        return try MetaDecoder(translator: 🚂Translator(), raw: self)
    }
    
}


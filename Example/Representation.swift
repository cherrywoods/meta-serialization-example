//
//  Representation.swift
//  Examples
//
//  Created by cherrywoods on 29.01.18.
//

import Foundation
import MetaSerialization

protocol 🚂: Representation {  }

extension String: 🚂 {
    
    public static func provideNewEncoder() -> MetaEncoder {
        return MetaEncoder(metaSupplier: 🚂Translator())
    }
    
    public func provideNewDecoder() -> MetaDecoder {
        return MetaDecoder(unwrapper: 🚂Translator())
    }
    
    public func convert() throws -> Meta {
        return TrainFormat.decode(from: self)
    }
    
    public init(meta: Meta) throws {
        self = TrainFormat.encode(meta: meta)
    }
    
}

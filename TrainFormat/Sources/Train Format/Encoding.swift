//
//  Encoding.swift
//  Examples
//
//  Created by cherrywoods on 22.01.18.
//

import Foundation
import MetaSerialization

extension TrainFormat {
    
    static func encode(meta topMeta: Meta) -> String {
        
        var train = TrainFormat.locomotive
        var toEncodeNext = [Meta]()
        
        toEncodeNext.append(topMeta)
        
        var meta: Meta
        while toEncodeNext.first != nil {
            
            meta = toEncodeNext.removeFirst()
            
            // add the wagon start
            train += TrainFormat.wagonBeginning
            
            if let singleValue = meta as? SingleValueMeta {
                
                // this is a case that should only occur once,
                // if topMeta is a SingleValueMeta.
                train += "\"\(singleValue.string)\""
                
            } else {
                
                // this is the normal case,
                // meta is a ContainerMeta.
                var referenceCounter = 1
                
                for (key, value) in (meta as! ContainerMeta).subMetas {
                    
                    // add the key
                    train += "\"\(key)\""
                    train += TrainFormat.keyValueSeparator
                    
                    if let singleValue = value as? SingleValueMeta {
                        
                        // encode as string value
                        train += "\"\(singleValue.string)\""
                        
                    } else {
                        
                        // encode as reference
                        train += reference(to: referenceCounter)
                        referenceCounter += 1
                        // encode this value in the next wagon
                        toEncodeNext.append(value)
                        
                    }
                    
                    // add the elements separator
                    train += TrainFormat.elementsSeparator
                    
                }
                
                // remove the last elementsSeparator again
                train.removeLast(2)
                // add the wagon end and the wagon connector
                train += TrainFormat.wagonEnding + TrainFormat.wagonConnector
                
            }
            
        }
        
        // remove the last wagon connector again
        train.removeLast()
        return train
        
    }
    
}

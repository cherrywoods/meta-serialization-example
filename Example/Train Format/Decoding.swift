//
//  Decoding.swift
//  Examples
//
//  Created by cherrywoods on 24.01.18.
//

import Foundation
import MetaSerialization

extension TrainFormat {
    
    static func decode(from train: String) -> Meta {
        var train = train
        // remove 🚂
        train.removeFirst()
        
        var wagons = [[String:ValueType]]()
        
        // split into wagons
        // this is used to ignore ['s and ]'s in string values
        // we assert, that there are no nested "s contained.
        var isStringOpened = false
        var currentWagon: [String:ValueType] = [:]
        
        var lastKey = ""
        var currentElement = ""
        
        // find wagons, strings and references
        
        for character in train {
            
            switch character {
                
            // finding wagon beginnings and endings
            case TrainFormat.wagonBeginning.first!:
                // only append [ to the wagon, if it is in a string
                // directly drop the [ at the beginning
                // and the ] at the ending
                if isStringOpened {
                    currentElement.append(character)
                }
            case TrainFormat.wagonEnding.first!:
                if isStringOpened {
                    currentElement.append(character)
                } else {
                    
                    // finish last element
                    // see below:
                    currentElement.removeFirst()
                    currentWagon[lastKey] = ValueType(currentElement)
                    currentElement = ""
                    
                    // this is the wagon ending
                    // append it to wagons
                    // and reset currentWagon
                    wagons.append(currentWagon)
                    currentWagon = [:]
                    
                }
                
            // differentiate between keys and values
            case TrainFormat.keyValueSeparator.first!:
                if !isStringOpened {
                    lastKey = currentElement
                    currentElement = ""
                }
            case TrainFormat.elementsSeparator.first!:
                if !isStringOpened {
                    // remove the first space from the value
                    currentElement.removeFirst()
                    
                    // insert key and value
                    // ValueType.init removes further unncessary characters, like "
                    currentWagon[lastKey] = ValueType(currentElement)
                    
                    currentElement = ""
                }
               
            // do not keep ¬'s
            case "¬":
                if !isStringOpened {
                    break
                } else {
                    fallthrough
                }
                
            // mark strings
            case "\"":
                // as mentioned, no nested "s
                isStringOpened = !isStringOpened
                fallthrough
                
            // append any other character to currentElement
            default:
                currentElement.append(character)
                
            }
            
        }
        
        // now check first if the given string contained only a single value wagon
        // in this case, wagons only contain a single empty dictionary
        if wagons.count == 1 && wagons[0].isEmpty {
            
            // remove [" and "]
            train.removeFirst(2)
            train.removeLast(2)
            
            return SingleValueMeta(string: train)
            
        }
        
        // now the further steps are pretty simple
        // convert the wagons to metas from the end to the start
        // this will make resolving references easy
        
        // the metas in reversed order
        // the final meta will be the last element
        var metas = [Meta]()
        
        var subMetas: Dictionary<String, Meta>
        
        for wagon in wagons.reversed() {
            
            // all wagons in here are ContainerMetas
            
            subMetas = Dictionary<String, Meta>()
            
            // create or get the subMetas
            for (var key, value) in wagon {
                
                // remove blank at the beginning
                if key.first! == " " {
                    key.removeFirst()
                }
                
                // remove " and "
                key.removeFirst()
                key.removeLast()
                
                switch value {
                case .reference(let relativeIndex):
                    // resolve reference
                    // the first relative index is 1.
                    // therefore we do not need to subtract 1 from the count
                    subMetas[key] = metas[ metas.count - relativeIndex ]
                case .string(let string):
                    // just add the unreferenced single values
                    subMetas[key] = SingleValueMeta(string: string)
                }
                
            }
            
            metas.append( ContainerMeta(subMetas: subMetas) )
            
        }
        
        // NOTE: remove "s in keys and values
        
        // the last most meta is the top meta
        return metas.last!
        
    }
    
    fileprivate enum ValueType {
        case string(String)
        case reference(Int)
        
        init?(_ string: String) {
            
            if string.first == "\"" {
                // remove "s
                self = ValueType.string( String(string.dropFirst().dropLast()) )
                
            } else if let index = TrainFormat.relativeIndex(from: string) {
                
                self = ValueType.reference(index)
                
            } else {
                
                return nil
                
            }
            
        }
        
    }
    
}

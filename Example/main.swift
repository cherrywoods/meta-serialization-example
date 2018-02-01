//
//  main.swift
//  Examples
//
//  Created by cherrywoods on 19.01.18.
//

import Foundation
import MetaSerialization

// this serialization format is just for
// demonstration purposes, therefore it does
// not support some things, e.g.
// nested " characters in string values

print("Encoding and Decoding this Train instance:")

let train = Train(length: 150,
                  speed: 100.7,
                  productionLine: .tgv,
                  passengers: [ "Fred": Passenger()!,
                                "Maria": Passenger()!,
                                "Pedro": Passenger("😞")!, // the tickets were expensive
                                "Amy": Passenger()! ])

print(train)
print()

print("Encoded instance: ")

// example usage of the serialization implementation
let encoded = try! 🚂Serialization().encode(train)
print(encoded)
print()

print("Decoded instance: ")
// example usage of the representation implementation
let decoded = try! (encoded as 🚂).decode(type: Train.self)
print(decoded)

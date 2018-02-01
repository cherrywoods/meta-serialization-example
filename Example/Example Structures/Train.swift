//
//  Train.swift
//  ExampleForMetaSerialization
//
//  Created by cherrywoods on 01.02.18.
//

import Foundation

// we will encode and decode this example struct
struct Train: Codable {
    
    let length: UInt
    let speed: Double
    
    let productionLine: ProductionLine
    
    enum ProductionLine: String, Codable {
        
        case ice = "ICE"
        case tgv = "TGV"
        
    }
    
    let passengers: [String: Passenger]
    
    init(length: UInt, speed: Double, productionLine: ProductionLine, passengers: [String: Passenger]) {
        
        self.length = length
        self.speed = speed
        self.productionLine = productionLine
        self.passengers = passengers
        
    }
    
}

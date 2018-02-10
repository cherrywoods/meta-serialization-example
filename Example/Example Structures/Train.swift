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
        
        init(from decoder: Decoder) throws {
            
            let sVC = try decoder.singleValueContainer()
            let stringValue = try sVC.decode(String.self)
            
            self.init(rawValue: stringValue)!
            
        }
        
        func encode(to encoder: Encoder) throws {
            
            var sVC = encoder.singleValueContainer()
            
            try sVC.encode( self.rawValue )
            
        }
        
    }
    
    let passengers: [String : Passenger]
    
    init(length: UInt, speed: Double, productionLine: ProductionLine, passengers: [String : Passenger]) {
        
        self.length = length
        self.speed = speed
        self.productionLine = productionLine
        self.passengers = passengers
        
    }
    
    // MARK: Codable code similar or equal to the code generated automatically
    
    // these implementations just exist for better understanding
    
    enum CodingKeys: String, CodingKey {
        case length
        case speed
        case productionLine
        case passengers
    }
    
    init(from decoder: Decoder) throws {
        
        let keyed = try decoder.container(keyedBy: CodingKeys.self)
        
        self.length = try keyed.decode(UInt.self, forKey: .length)
        self.speed = try keyed.decode(Double.self, forKey: .speed)
        self.productionLine = try keyed.decode(ProductionLine.self, forKey: .productionLine)
        self.passengers = try keyed.decode([String : Passenger].self, forKey: .passengers)
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var keyed = encoder.container(keyedBy: CodingKeys.self)
        
        try keyed.encode(self.length, forKey: .length)
        try keyed.encode(self.speed, forKey: .speed)
        try keyed.encode(self.productionLine, forKey: .productionLine)
        try keyed.encode(self.passengers, forKey: .passengers)
        
    }
    
}

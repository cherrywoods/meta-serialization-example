//
//  main.swift
//  Flaschengeist
//  
//  Copyright 2018 cherrywoods
//
//  Available at the terms of the LICENSE file included in this project.
//  If none is included, available at the terms of the CC0 license. 
//  See https://creativecommons.org/publicdomain/zero/1.0/legalcode.
// 

// for simplicity this example has only a decoding capability
// it decodes from 🔦 to three arbitrary types (as long as it's String, Int or Double)

import Foundation

let lamp = "🔦"
print(" -- Oh! how cool. I found a lamp: \(lamp) -- ")
print(" -- Maybe it's also working... -- ")
print(" Swosh! White smoke fills the air and a genie appears. ")
let genie = Genie()
print( genie.description )
print(" ** Hey there. I'm a genie. ** ")
print(" -- Wow! Hey genie. Can I use Decoodable and so on to ask you three wishes? -- ")
print(" ** Oh of course! ** ")
print(" -- Cool, let's do this. -- ")
do {
    
    let result = try Genie().decode(lamp: lamp, to: ThreeWishes.self)
    print(" -- Wow! I got \(result.string), \(result.int) and nil! Amazing! ☺️ --")
    
} catch {
    
    print(" ** Wait, this didn't work. \(error) ** ")
    
}

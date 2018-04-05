//
//  ThreeWishes.swift
//  Flaschengeist
//  
//  Copyright 2018 cherrywoods
//
//  Available at the terms of the LICENSE file included in this project.
//  If none is included, available at the terms of the CC0 license. 
//  See https://creativecommons.org/publicdomain/zero/1.0/legalcode.
// 

import Foundation

struct ThreeWishes: Decodable {
    
    let string: String
    let int: Int
    
    init(from decoder: Decoder) throws {
        
        print("In ThreeWishes.init(from:)")
        print(" -- Hm... I'd like to request my wishes using an unkeyed container -- ")
        var container = try decoder.unkeyedContainer()
        print(" ** Granted. You still have three wishes. ** ")
        
        print(" -- I wish a String. -- ")
        self.string = try container.decode(String.self)
        print(" ** Good choice. This is your string: \(string) **")
        
        print(" -- Hm... A string was what I always wished for... What should I wish now? -- ")
        print(" -- Ok. I know it. Give me an Int. -- ")
        self.int = try container.decode(Int.self)
        print(" ** This is your int: \(int). Have fun with it. **")
        print(" ** You still have one wish left. **")
        
        print(" -- Oh no. This immense preasure. 😩 -- ")
        print(" ** Thats the game. Now wish. Don't waste my time. **")
        print(" -- Ah... Well... Hmmm... 🤔 -- ")
        print(" -- Ok. I want a car! -- ")
        print(" ** This is your last wish. Are you sure you wan't a car? **")
        print(" -- Oh! No! Better! A plane! -- ")
        print(" ** Remember, this is your last wish. **")
        print(" -- You wan't to say, I should wish money? -- ")
        print(" ** I'm just forfilling your wishes. I can't tell you what you should wish. **")
        print(" -- Maybe I should just wish, what I should wish. -- ")
        print(" -- Ah, no, this is my last wish, then I would know what I wanted but I could not get it. -- ")
        print(" ** Don't waist my time. You have 30 seconds to decide. **")
        print(" -- Oh god, it's so difficult, there are so many possiblities... -- ")
        print(" -- A new computer? A new phone? A third arm? Maybe just a hot drink? -- ")
        print(" ** 20 seconds left. **")
        print(" -- What about vacation? An unicorn? Oh, I know: I wish another three wishes. -- ")
        print(" ** You can't have that wish. 10 seconds left. **")
        print(" -- What about another 30 seconds? -- ")
        print(" ** No. 5 seconds left. **")
        print(" -- Oh no, oh no! 😭 Ah! I know! I wish nil. -- ")
        print(" ** Ok. You can have nil: **")
        let isNil = try container.decodeNil()
        if !isNil { print(" ** (Silent) Oh no this didn't work. Silly technology! Ah I know what to do: ** ") }
        print(" ** Here's youre nil:  (The thing is, you can't see it!) ** ")
        print(" ** Bye bye ** ")
        
    }
    
}

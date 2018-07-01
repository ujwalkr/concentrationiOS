//
//  Card.swift
//  Cincentration
//
//  Created by Admin on 26/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var hashValue: Int { return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    

    var isFlipedUp = false
    var isMatched = false
    private var identifier:Int
    
    private static var uniqueIdentifier = 0
    
    private static func getUniqueIdentifier()-> Int{
        uniqueIdentifier += 1
        return uniqueIdentifier
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}



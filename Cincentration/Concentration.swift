//
//  Concentration.swift
//  Cincentration
//
//  Created by Admin on 26/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

struct Concentration {
    
   private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCads : Int? {
        get{
            return cards.indices.filter { cards[$0].isFlipedUp}.oneAndOnly
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
//            var foundIndex :Int?
//            for index in cards.indices {
//                if cards[index].isFlipedUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else{
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set{
            for index in cards.indices {
                cards[index].isFlipedUp = (index == newValue)
            }
        }
    }
    
   mutating func chooseCard(at index:Int){
        assert(cards.indices.contains(index),"Concentration.chooseCard(at: \(index)) : chosen index is not in cards ")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCads , matchIndex != index{
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFlipedUp = true
                
            }else{
                indexOfOneAndOnlyFaceUpCads = index
            }
        }
    }
    
    init(numberOfPairOfCards: Int){
         assert(numberOfPairOfCards > 0,"Concentration.init(\(numberOfPairOfCards)) : number of pair of card should be > 0")
        for _ in 0..<numberOfPairOfCards {
            let card = Card()
            cards += [card,card]
        }
        //TODO: shuffel cards
    }
}

extension Collection{
    var oneAndOnly : Element?{
        return count == 1 ? first : nil
    }
}

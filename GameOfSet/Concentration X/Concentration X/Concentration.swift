//
//  Concentration.swift
//  Concentration X
//
//  Created by Pranav Patil on 2/6/19.
//  Copyright © 2019 Pranav Patil. All rights reserved.
//

import Foundation

struct Concentration {
    
    var flipCount: Int = 0;
    var scores: Int = 0;
    
    private var indexofOneAndOnlyFaceUpCard: Int?
    
    private(set) var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
            
        }
    }
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index is not in the cards)")
        
        if !cards[index].isMatched {
            if let matchIndex = indexofOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards [matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scores+=1
                }
                else if(scores > 0){
                    scores-=1
                }
                cards[index].isFaceUp = true
                indexofOneAndOnlyFaceUpCard = nil
            }
            else {
                //either no cards or 2 cards
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexofOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func startGame(){
        
        if flipCount >= 0 {
            for card in 0..<cards.count {
                cards[card].isMatched = false
                cards[card].isFaceUp = false
            }
        }
        //Above if statement is to make sure the game gets reset upon someone hitting the startgame button.
        
        shuffleme()
        flipCount = 0;
        scores = 0;
        
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //let card = Card(identifier: identifier)
        shuffleme()
    }
    //TODO: shuffle cards
    mutating func shuffleme(){
        cards.shuffle();
    }
}


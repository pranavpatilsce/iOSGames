//
//  ViewController.swift
//  Concentration X
//
//  Created by Pranav Patil on 2/2/19.
//  Copyright © 2019 Pranav Patil. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var choices = ChoicesOfEmoji()
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func StartAction(_ sender: UIButton) {
        
        emojiChoices = []
        
        emoji = [:]
        
        game.startGame();
        
        flipCountLabel.isHidden = false;
        
        let randomIndex = Int(arc4random_uniform(UInt32(choices.dictionaryStore.count)))
        
        emojiChoices = Array(choices.dictionaryStore.values)[randomIndex]
        //found some inspiration on stack overflow
        updateViewFromModel();
    }
    
    /*
     YOU CAN ADD NEW EMOJI THEME BY ADDING TO THE DICTIONARY USING THE FOLLOWING:
     
     dictionaryStore["NAMEOFEMOJI"] = "" //put the emoji in the string
    */
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        game.flipCount += 1;
        
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else{
            print("Chosen Card was not in cardButtons")
        }
    }
    
    func updateViewFromModel(){
        
        flipCountLabel.text = "FLIPS: \(game.flipCount)"
        scoreLabel.text = "SCORE: \(game.scores)"
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0): #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            }
        }
    }
    
    var emojiChoices: [String] = []
 
    var emoji = [Int: String]()
    
    func emoji (for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
     override func viewDidLoad() {
     super.viewDidLoad()
        flipCountLabel.isHidden = true;
        // Do any additional setup after loading the view, typically from a nib.
     }
    
}


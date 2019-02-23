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
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards) //(cardButtons.count + 1) / 2)
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count + 1)/2
        }
    }
    
    private(set) var flipCount = 0 {
        
        didSet{
            updateFlipCountLabel()
        }
        
    }
    
    private func updateFlipCountLabel(){
        
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor : #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips:\(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
        
    }
    
    
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet private var cardButtons: [UIButton]!
    
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
    
    private func updateViewFromModel(){
        
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
    
    //private var emojiChoices: [String] = []
 
    private var emojiChoices = "😀🚴♂️💀🦓🐂🐿👬🏄♀️"
    
    private var emoji = [Card: String]()
    
    private func emoji (for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            //let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
            
            //emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
     }
    
     override func viewDidLoad() {
     super.viewDidLoad()
        flipCountLabel.isHidden = true;
        // Do any additional setup after loading the view, typically from a nib.
     }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }
        else {
            return 0
        }
    }
}

//
//  ViewController.swift
//  Cincentration
//
//  Created by Admin on 26/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

@IBDesignable
class ConcentrastionViewController: UIViewController {
    
    private(set) var flipCount = 0 {
        didSet{
           updateFlipCountLabel()
        }
    }
    
    
    /// This method update the flip count label
    private func updateFlipCountLabel(){
        let attributes : [NSAttributedStringKey: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.black
        ]
        let attributedString = NSAttributedString(
            string: traitCollection.verticalSizeClass == .compact ?"Flips\n\(flipCount)" : "Flips: \(flipCount)",
            attributes: attributes)
        
        if flipCountLabel != nil{
            flipCountLabel.attributedText = attributedString
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFlipCountLabel()
    }
    
   private lazy var game  = Concentration(numberOfPairOfCards: numberOfPairOfCards)
    
    var numberOfPairOfCards :Int {
            return (visibleCardButtons.count + 1)/2
    }
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var visibleCardButtons: [UIButton]!{
        return cardButtons?.filter{!$0.superview!.isHidden}
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = visibleCardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("card not in cardBtn")
        }
    }
    
    private func updateViewFromModel(){
        if visibleCardButtons != nil {
            for index in visibleCardButtons.indices {
                let button = visibleCardButtons[index]
                let card = game.cards[index]
                
                if(card.isFlipedUp){
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }else{
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) :#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
            }
        }
    }
    
//   private var emojiChoices = ["👻","🎃","🐉","🎠","🚀","🛰","🦑","🐯","🦅","🤡"]
   
    var theme: String?{
        didSet{
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
   private var emojiChoices = "👻🎃🐉🎠🚀🛰🦑🐯🦅🤡"
   private var emoji = [Card:String]()
    
   private func emoji(for card:Card)-> String {
        if emoji[card] == nil, emojiChoices.count > 0{
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
}

extension Int{
    var arc4random : Int{
        if self > 0 {
        return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}

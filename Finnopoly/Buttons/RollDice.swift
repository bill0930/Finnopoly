//
//  RollDice.swift
//  Finnopoly
//
//

import Foundation
import SpriteKit

class RollDice : SKSpriteNode
{
    private let rollButton = SKSpriteNode(imageNamed: "RollDiceButton")
    private var die1 = SKSpriteNode(imageNamed: "die_6")
    private var die2 = SKSpriteNode(imageNamed: "die_6")
    var mySteps : Int = 0
    
    init(size: CGSize, frame: CGRect)
    {
        super.init(texture: nil, color: .clear, size: frame.size)
        print(frame.size)
        setup(size: frame.size)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup(size: frame.size)
    }
    
    func setup(size: CGSize)
    {
        rollButton.zPosition = 300
        rollButton.setScale(1)
        
        die1.setScale(0.5)
        die2.setScale(0.5)
        die1.position = CGPoint(x: -30, y: 80)
        die2.position = CGPoint(x: 30, y: 80)
        die1.zPosition = 1000
        die2.zPosition = 1000
        
        addChild(rollButton)
        addChild(die1)
        addChild(die2)
    }
    
    func setPressed()
    {
        let action = SKAction.scale(to: 0.5, duration: 0.1)
        rollButton.run(action)
    }
    
    func rollDice() -> Int
    {
        let die1_result = Int.random(in: 1...6)
        let die2_result = Int.random(in: 1...6)
        mySteps = die1_result + die2_result
        
        // debug use
        print("Die 1: \(die1_result)")
        print("Die 2: \(die2_result)")
        
        var diceNum_1 : String = "die_6"
        var diceNum_2 : String = "die_6"

        switch die1_result
        {
            case 1:
                diceNum_1 = "die_1"
                break
            case 2:
                diceNum_1 = "die_2"
                break
            case 3:
                diceNum_1 = "die_3"
                break
            case 4:
                diceNum_1 = "die_4"
                break
            case 5:
                diceNum_1 = "die_5"
               break
            default:
                diceNum_1 = "die_6"
        }

        switch die2_result
        {
            case 1:
                diceNum_2 = "die_1"
                break
            case 2:
                diceNum_2 = "die_2"
                break
            case 3:
                diceNum_2 = "die_3"
                break
            case 4:
                diceNum_2 = "die_4"
                break
            case 5:
                diceNum_2 = "die_5"
               break
            default:
                diceNum_2 = "die_6"
        }
        
        die1.run(SKAction.setTexture(SKTexture(imageNamed: diceNum_1)))
        die2.run(SKAction.setTexture(SKTexture(imageNamed: diceNum_2)))

        rollButton.run(SKAction.scale(to: 1, duration: 0.15))
        
        return mySteps
    }
    
    func setReleased()
    {
        rollButton.run(SKAction.scale(to: 1, duration: 0.15))
    }
}

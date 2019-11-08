//
//  RollDice.swift
//  Finnopoly
//
//

import Foundation
import SpriteKit
import Darwin

class RollDice : SKSpriteNode
{
    private let rollButton = SKSpriteNode(imageNamed: "RollDiceButton")
    private var die1 = SKSpriteNode(imageNamed: "die_6")
    private var die2 = SKSpriteNode(imageNamed: "die_6")
    
    private var toRoll = false
    
    init(size: CGSize)
    {
        super.init(texture: nil, color: .clear, size: size)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup()
    {
        rollButton.zPosition = 0
        rollButton.setScale(0.5)
        die1.setScale(0.25)
        die2.setScale(0.25)
        
        addChild(rollButton)
        addChild(die1)
        addChild(die2)
    }
    
    func setPressed() -> Int
    {
        let action = SKAction.scale(to: 1, duration: 0.1)
        rollButton.run(action)
        
        let die1_result = Int(1 + arc4random_uniform(6))
        let die2_result = Int(1 + arc4random_uniform(6))
        let mySteps = die1_result + die2_result
        
        switch die1_result
        {
        case 1:
            die1 = SKSpriteNode(imageNamed: "die_1.png")
        case 2:
            die1 = SKSpriteNode(imageNamed: "die_2.png")
        case 3:
            die1 = SKSpriteNode(imageNamed: "die_3.png")
        case 4:
            die1 = SKSpriteNode(imageNamed: "die_4.png")
        case 5:
           die1 = SKSpriteNode(imageNamed: "die_5.png")
        default:
            die1 = SKSpriteNode(imageNamed: "die_6.png")
        }
        
        switch die2_result
        {
        case 1:
            die1 = SKSpriteNode(imageNamed: "die_1.png")
        case 2:
            die1 = SKSpriteNode(imageNamed: "die_2.png")
        case 3:
            die1 = SKSpriteNode(imageNamed: "die_3.png")
        case 4:
            die1 = SKSpriteNode(imageNamed: "die_4.png")
        case 5:
           die1 = SKSpriteNode(imageNamed: "die_5.png")
        default:
            die1 = SKSpriteNode(imageNamed: "die_6.png")
        }
        die1.run(action)
        die2.run(action)
        
        return mySteps
    }
    
//    var mySteps = 0
//    var gameStatus:String!
//    var die1:Int!
//    var die2:Int!
//
//    init(playerStatus: String)
//    {
//        gameStatus = playerStatus
//        die1 = Int(1 + arc4random_uniform(6))
//        die2 = Int(1 + arc4random_uniform(6))
//        mySteps = die1 + die2
//    }
//
//    func rollDice_1() -> String
//    {
//        // arc4random_uniform(6) outcome range: 0-5
//        // so have to "1 +"
//        if gameStatus == "Continue"
//        {
//            print("Result of the die1 is \(die1!)}")
//            switch die1
//            {
//            case 1:
//                return "die_1.png"
//            case 2:
//                return "die_2.png"
//            case 3:
//                return "die_3.png"
//            case 4:
//                return "die_4.png"
//            case 5:
//                return "die_5.png"
//            default:
//                return "die_6.png"
//            }
//        }
//        else
//        {
//            return ""
//        }
//    }
//
//    func rollDice_2() -> String
//    {
//        // arc4random_uniform(6) outcome range: 0-5
//        // so have to "1 +"
//        if gameStatus == "Continue"
//        {
//            print("Result of the die1 is \(die2!)}")
//            switch die2
//            {
//            case 1:
//                return "die_1.png"
//            case 2:
//                return "die_2.png"
//            case 3:
//                return "die_3.png"
//            case 4:
//                return "die_4.png"
//            case 5:
//                return "die_5.png"
//            default:
//                return "die_6.png"
//            }
//        }
//        else
//        {
//            return ""
//        }
//    }
    
//    func rollDice() -> (die1: Int, die2:Int)
//    {
//        // arc4random_uniform(6) outcome range: 0-5
//        // so have to "1 +"
//        let die1 = Int(1 + arc4random_uniform(6))
//        let die2 = Int(1 + arc4random_uniform(6))
//
//        print("Result of the roll is \(die1+die2)")
//        return(die1, die2)
//
//    }
}

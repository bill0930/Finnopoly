//
//  RollDice.swift
//  Finnopoly
//
//  Created by Jacklin Chan on 4/11/2019.
//  Copyright © 2019 Finnopoly. All rights reserved.
//

import Foundation
import Darwin

class RollDice
{
    
    var mySteps = 0
    var gameStatus:String!
    var die1:Int!
    var die2:Int!

    init(playerStatus: String)
    {
        gameStatus = playerStatus
        die1 = Int(1 + arc4random_uniform(6))
        die2 = Int(1 + arc4random_uniform(6))
        mySteps = die1 + die2
    }

    func rollDice_1() -> String
    {
        // arc4random_uniform(6) outcome range: 0-5
        // so have to "1 +"
        if gameStatus == "Continue"
        {
            print("Result of the die1 is \(die1!)}")
            switch die1
            {
            case 1:
                return "die_1.png"
            case 2:
                return "die_2.png"
            case 3:
                return "die_3.png"
            case 4:
                return "die_4.png"
            case 5:
                return "die_5.png"
            default:
                return "die_6.png"
            }
        }
        else
        {
            return ""
        }
    }
    
    func rollDice_2() -> String
    {
        // arc4random_uniform(6) outcome range: 0-5
        // so have to "1 +"
        if gameStatus == "Continue"
        {
            print("Result of the die1 is \(die2!)}")
            switch die2
            {
            case 1:
                return "die_1.png"
            case 2:
                return "die_2.png"
            case 3:
                return "die_3.png"
            case 4:
                return "die_4.png"
            case 5:
                return "die_5.png"
            default:
                return "die_6.png"
            }
        }
        else
        {
            return ""
        }
    }
    
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

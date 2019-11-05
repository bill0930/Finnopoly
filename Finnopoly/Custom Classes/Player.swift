//
//  Player.swift
//  Finnopoly
//
//  Created by CHAN CHI YU on 23/10/2019.
//  Copyright © 2019 Finnopoly. All rights reserved.
//

import SpriteKit
import Foundation

class Player: SKSpriteNode {
    var walletAmount : Double? = 0
    var currentStation: String?  //The stationName
    var holdingProps: [String] = []
    
     func getPropsCount() -> Double {
        return Double(self.holdingProps.count)
    }
    
    
    func printDebug(){
        print("walletAmount: \(String(describing: walletAmount!))")
        print("currentStation: \(String(describing: currentStation!))")
        print("cuurentPosition: \(self.position)")
        print("holdingProps: \(holdingProps)")

    }
   
}

//
//  Property.swift
//  Finnopoly
//
//  Created by CHAN CHI YU on 4/11/2019.
//  Copyright © 2019 Finnopoly. All rights reserved.
//

import Foundation
import SpriteKit

class Property: SKSpriteNode{
    //SKSPriteNode already has the name, position() and texture properties
    var owner: String = ""
    var maxInvestment: Double = 0.0
    var originalPrice: Double = 0.0
    var curInvestment: Double = 0.0
    var level:Int = 1
    
    //  texture propertie is for the image display
    //  please resize the image 130 X 130 and put it into texture
    //  you may use setter to do the conditional setting
    
    //    override var texture: SKTexture? {
    //        set {
    //
    //        }
    //    }
    
    //Varies based on Original Price, Investment, Number of properties owned by same owner on the line
    var tollPrice: Double {
        get {
            //dunno how to get the Number of properties owned by same owner on the line
            let levelPrice: Double = originalPrice * Double(level)
            return (levelPrice * 0.5 +  curInvestment * 0.5)
        }
    }
    
    func setProperties(maxInvestment: Double, originalPrice: Double) {
        self.maxInvestment = maxInvestment
        self.originalPrice = originalPrice
    }
    
    //debug
    func printDebug() {
        print("name: \(String(describing: self.name!))")
        print("owner: \(self.owner)")
        print("maxInvestment: \(self.maxInvestment)")
        print("originalPrice: \(self.originalPrice)")
        print("curInvestment: \(self.curInvestment)")
        print("level: \(self.level)")
        print("tollPrice: \(self.tollPrice)")
    }
    
}

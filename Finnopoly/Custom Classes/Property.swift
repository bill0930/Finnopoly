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
    
    // override var texture: SKTexture? {
    //set {
    //
    //      }
    // }
    
    
    //Varies based on Original Price, Investment 
    var tollPrice: Double {
        get {
            //dunno how to get the Number of properties owned by same owner on the line
            let price = originalPrice*0.4 + curInvestment*0.4
            //let levelPrice: Double = originalPrice * Double(level)
            return floor(price)
        }
    }
    
    func setProperties(maxInvestment: Double, originalPrice: Double) {
        self.maxInvestment = maxInvestment
        self.originalPrice = originalPrice
    }
    
    func setPropLevel() {
        var level = 0
        var action = SKAction.setTexture(SKTexture(imageNamed: "house_0.png"))
        if owner != ""{
            switch(tollPrice) {
            case 0...99:
                level = 1
                action = SKAction.setTexture(SKTexture(imageNamed: "house_1.png"))
                
                
            case 100...499:
                level = 2
                action = SKAction.setTexture(SKTexture(imageNamed: "house_2.png"))
                
                
            case 500...1000:
                level = 3
                action = SKAction.setTexture(SKTexture(imageNamed: "house_3.png"))
                
                
            case 1001...2000:
                level = 4
                action = SKAction.setTexture(SKTexture(imageNamed: "house_4.png"))
                
                
            default:
                level = 5
                action = SKAction.setTexture(SKTexture(imageNamed: "house_5.png"))
            }
        }
        self.level = level
        self.run(action)
        self.zPosition = CGFloat(GameConstants.Properties.propertyZposition)
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
        print(self.texture)
    }
    
}

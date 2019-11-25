//
//  Display.swift
//  Finnopoly
//
//  Created by Jacklin Chan on 24/11/2019.
//  Copyright © 2019 Finnopoly. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Display: SKSpriteNode
{
    private let displayButton = SKSpriteNode(imageNamed: "Player")
    
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
        displayButton.zPosition = 300
        displayButton.setScale(0.08)

        addChild(displayButton)
    }

    
    func setPressed()
    {
        let action = SKAction.scale(to: 0.05, duration: 0.1)
        displayButton.run(action)
    }
    
    func setReleased()
    {
        displayButton.run(SKAction.scale(to: 0.08, duration: 0.15))
    }
}

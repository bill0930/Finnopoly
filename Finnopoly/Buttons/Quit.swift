//
//  Quit.swift
//  Finnopoly
//
//  Created by Jacklin Chan on 11/11/2019.
//  Copyright © 2019 Finnopoly. All rights reserved.
//
import Foundation
import SpriteKit

class Quit: SKSpriteNode
{
    private let quitButton = SKSpriteNode(imageNamed: "QuitButton")
    
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
        quitButton.zPosition = 300
        quitButton.setScale(0.65)

        addChild(quitButton)
    }

    
    func setPressed()
    {
        let action = SKAction.scale(to: 0.5, duration: 0.1)
        quitButton.run(action)
    }
    
    func setReleased()
    {
        quitButton.run(SKAction.scale(to: 0.65, duration: 0.15))
    }
}

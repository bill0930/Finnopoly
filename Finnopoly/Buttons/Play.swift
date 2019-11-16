//
//  Play.swift
//  Finnopoly
//
//  Created by Oscar Chan on 14/11/2019.
//  Copyright © 2019 Finnopoly. All rights reserved.
//

import UIKit
import SpriteKit

class Play: SKSpriteNode
{
    private let playButton = SKSpriteNode(imageNamed: "PlayButton")
    
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
        playButton.zPosition = 300
        playButton.setScale(1)

        addChild(playButton)
    }

    
    func setPressed()
    {
        let action = SKAction.scale(to: 0.5, duration: 0.1)
        playButton.run(action)
    }
    
    func setReleased()
    {
        playButton.run(SKAction.scale(to: 0.9, duration: 0.15))
    }
}

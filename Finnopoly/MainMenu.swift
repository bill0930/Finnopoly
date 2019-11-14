//
//  MainMenu.swift
//  Finnopoly
//
//  Created by Jacklin Chan on 11/11/2019.
//  Copyright © 2019 Finnopoly. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenu: SKScene {
    var playBtnSprite : SKAControlSprite!
    var playForegroundSprite : Play!
    var playMask : Play!
    
    override func didMove(to view: SKView)
    {
        let cropNode = SKCropNode()
        cropNode.zPosition = 100
        cropNode.position = CGPoint(x: 0, y: 0)
        
        let maskNode = SKNode()
        maskNode.zPosition = 100
        cropNode.maskNode = maskNode
        
        setupPlayButton(maskNode: maskNode)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let pos = touch.location(in: self)
//            let node = self.atPoint(pos)
//
//            if node == playButton {
//                if let view = view
//                {
//                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
//                    let scene:SKScene = GameScene(fileNamed: "GameScene")!
//                    //scene.viewController = self
//                    self.view?.presentScene(scene, transition: transition)
//                }
//            }
//        }
    }
    
    func setupPlayButton(maskNode: SKNode)
    {
        playBtnSprite = SKAControlSprite(color: .clear, size: CGSize(width: 50, height: 50))
        
//        let upLeftView = CGPoint(x: 0, y: 0)
//        playBtnSprite.position = convertPoint(fromView: upLeftView)
        playBtnSprite.position = CGPoint(x: 0, y: 0)
        playBtnSprite.zPosition = 1000
        self.addChild(playBtnSprite)
        
        // set the action for certain events
        playBtnSprite.addTarget(self, selector: #selector(playButtonTouchDown), forControlEvents: [.TouchDown, .DragEnter])
        playBtnSprite.addTarget(self, selector: #selector(playButtonTouchUpInside), forControlEvents: [.TouchUpInside])
        
        playMask = Play(size: playBtnSprite.size, frame: frame)
        playMask.position = playBtnSprite.position
        
        playForegroundSprite = Play(size: playBtnSprite.size, frame: frame)
        playForegroundSprite.position = playBtnSprite.position
        
        maskNode.addChild(playMask)
        self.addChild(playForegroundSprite)
    }
    
    @objc func playButtonTouchDown()
    {
        playForegroundSprite.setPressed()
        playMask.setPressed()
    }
    
    @objc func playButtonTouchUpInside()
    {
        playForegroundSprite.setReleased()
        playMask.setReleased()
        print("Play Button Pressed \n#####################")
        if let view = view
        {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = GameScene(fileNamed: "GameScene")!
//            scene.viewController = self
            self.view?.presentScene(scene, transition: transition)
        }
    }
    
}

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
    var playButton = SKSpriteNode()
    let playButtonTex = SKTexture(imageNamed: "PlayButton")

    override func didMove(to view: SKView) {

        playButton = SKSpriteNode(texture: playButtonTex)
        playButton.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(playButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)

            if node == playButton {
                if let view = view {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = GameScene(size: self.size)
                    //scene.viewController = self
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
}

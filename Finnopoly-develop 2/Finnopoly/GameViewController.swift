//
//  GameViewController.swift
//  Finnopoly
//
//  Created by CHAN CHI YU on 22/10/2019.
//  Copyright © 2019 Finnopoly. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()

      if let view = self.view as! SKView? {
        // Load the SKScene from 'GameScene.sks'
        if let scene = GameScene(fileNamed: "GameScene") {
          // Set the scale mode to scale to fit the window
          scene.scaleMode = .aspectFill

          // Present the scene
          view.presentScene(scene)
        }

        view.ignoresSiblingOrder = true

        view.showsFPS = true
        view.showsNodeCount = true
        view.ignoresSiblingOrder = true
      }
    }
        
        
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

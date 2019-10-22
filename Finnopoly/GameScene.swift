//
//  GameScene.swift
//  Finnopoly
//
//  Created by CHAN CHI YU on 22/10/2019.
//  Copyright © 2019 Finnopoly. All rights reserved.
//

import SpriteKit
import SwiftGraph

class GameScene: SKScene {
    
    var mapNode: SKNode!
//    var brownLineStations: [Station] = []
//    var redLineStations: [Station] = []
    
    override func didMove(to view: SKView) {
        loadScene(filename: "GameScene")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func move(to node: Station){
        let nextNode = node.position + CGPoint(x: 100.0, y:0.0)
        node.run(SKAction.move(to: nextNode, duration: 0.5))
    }
    
    func loadScene(filename: String){
        if let routeMap = SKNode.unarchiveFromFile(file: filename){
            mapNode = routeMap
            addChild(mapNode)
            for child in mapNode.children {
                if child.name == "routeMap" {
                    for station in child.children {
                        print(station.name)
                    }
                }
            }
        }
    }
}

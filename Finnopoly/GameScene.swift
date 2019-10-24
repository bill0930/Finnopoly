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
    
    var stationVertices : [String] = []
    var routeGraph: UnweightedGraph<String>!
    var worldNode: SKNode!
    
    override func didMove(to view: SKView) {
        loadScene(filename: "GameScene")
        getCityGraph()
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
        if let world = SKNode.unarchiveFromFile(file: filename){
            worldNode = world
            addChild(worldNode)
            
            
        }
    }
    
    func getCityGraph(){
        //        let stationGraph: WeightedGraph<structStation, Int> = WeightedGraph<structStation, Int>()
        for child in worldNode.children {
            if child.name == "routeMap" {
                for station in child.children {
                    
                    if let tempName = station.name{
                        stationVertices.append(tempName)
                    }
                }
            }
        }
        //assign to the Graph
        routeGraph = UnweightedGraph<String>(vertices: stationVertices)
        print(routeGraph.vertexCount)
        
        graphConnection()
    }
    
    ///to mapped the routeMap into Graph
    func graphConnection(){
        //initialize the connection between station
        let lineColors = ["brown","orange","red","blue","purple","pink","cyan","grey","greenN","greenS"]
        let mapNode = worldNode.childNode(withName: "routeMap")!
        
        for color in lineColors {
            //            print(color)
            var stationArray = [String]() //store the stations for particular color line
            let nameCount: Int = mapNode.getCountWithName(withName: color)
            
            mapNode.enumerateChildNodes(withName: "*\(color)*"){ //help append all station into the Array with same color
                node, _ in
                stationArray.append(node.name!)
            }
            
            ///brown0<->brown1<->brown2<->brown3<->brown4
            /// for i in 0 to 3 so
            ///brown0<->brown1, brown1<->brown2, brown3<->brown4
            for i in 0...nameCount - 2 {
                let fromIndex: Int = (stationArray.firstIndex(where: {$0.contains(color + String(i)) } )!)
                let toIndex: Int = (stationArray.firstIndex(where: {$0.contains(color + String(i+1)) } )!)
                routeGraph.addEdge(from: stationArray[fromIndex],to: stationArray[toIndex], directed: false)
                //print(stationArray[fromIndex] + " is connected to " + stationArray[toIndex])
            }
            
        }
        /// for debugging
        
        //print out all the adjacent stations for  the statons name contains ("IC")
        for v in routeGraph {
            if v.contains("IC"){
                print("stations \(v) : \(routeGraph.neighborsForVertex(v)!)")
            }
        }
        
        //print out the first path from "IC-red0-brown0" to "IC-blue5-purple4" using bfs
        let result = routeGraph.bfs(from: "IC-red0-brown0") { (v) -> Bool in
            v == "IC-blue5-purple4"
        }
        for edge in result {
            print("\(routeGraph.vertexAtIndex(edge.u)) -> \(routeGraph.vertexAtIndex(edge.v))")
        }
        
    }

}

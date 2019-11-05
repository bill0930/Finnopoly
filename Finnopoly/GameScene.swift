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
    var player: Player?
    //hihihihihi
    
    override func didMove(to view: SKView) {
        worldNode = self
        
        getCityGraph()
        player = getPlayer(playerName: "Pepe")
//                !!!!!!!you may uncomment the below to see how to manipulate the properties!!!!
//                 e.g. get the property by stationName with "purple2"
                let testPropNode = getProperty(stationName: "purple2")! //pass by reference
        
                //print out the properties related to this property
                testPropNode.printDebug()
        
                //change this node's properties
                testPropNode.owner = player!.name!
                testPropNode.setProperties(maxInvestment: 1000.0, originalPrice: 100.0)
                //since it is passed by reference, by editing testPropNode, the original node will be changed
                print("------------after update---------")
                getProperty(stationName: "purple2")?.printDebug()
        
                //move the playerNode into brown1
                move(node: player!, to: "IC-red0-brown0")
                player?.walletAmount! += 1000000.0
                print("------------Updated Player---------")
                getPlayer(playerName: "Pepe")?.printDebug()
                //this function helps transvere all properties
                tranverseProperties()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    //MARK: -Scene Initialization
    /***************************************************************/
    
    ///to mapped the routeMap into Graph, with stationName as vertices
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
    //called in getCityGraph function
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
        //        //print out all the adjacent stations for  the statons name contains ("IC")
        //        for v in routeGraph {
        //            if v.contains("IC"){
        //                print("stations \(v) : \(routeGraph.neighborsForVertex(v)!)")
        //            }
        //        }
        //
        //        //print out the first path from "IC-red0-brown0" to "IC-blue5-purple4" using bfs
        //        let result = routeGraph.bfs(from: "IC-red0-brown0") { (v) -> Bool in
        //            v == "IC-blue5-purple4"
        //        }
        //        for edge in result {
        //            print("\(routeGraph.vertexAtIndex(edge.u)) -> \(routeGraph.vertexAtIndex(edge.v))")
        //        }
        
    }
    
}

extension GameScene {
    
    ///this function helps to move a Player node into particular station and update the current station of the PlayerNode
    /// - parameter node: the node as a Player
    /// - parameter station: thes station name as String
    func move(node: Player, to station: String){
        let newPos = (self.getStation(stationName: station)!).position
        let moveAction = SKAction.move(to: newPos, duration: 5.0)
        moveAction.timingMode = .easeOut
        node.run(moveAction)
        //assignment the currentStation
        node.currentStation = station
    }
    
    ///this function helps to transverse the all properties
    func tranverseProperties (){
        print("-----Printing all propertie name -----")
        for name in stationVertices {
            if let prop = getProperty(stationName: name){
                // you may do operations in here foreach prop
                print(prop.name!)
                prop.setProperties(maxInvestment: 200, originalPrice: 1)
            }
        }
    }
    
    //MARK: - Some Getter for Station, Property and Player by their stationName or playerName in the GameScene
    /***************************************************************/
    
    ///this function helps to retrieve the station of by StationName in GameScene.sks
    /// getStation is the function to accept statioName parametre and returns the Station node
    /// - parameter stationName: the name of the station
    func getStation(stationName: String) -> Station?{
        let stationNode = worldNode.childNode(withName: "routeMap")?.childNode(withName: stationName)!
        return (stationNode as! Station)
    }
    ///this function helps to retrieve the property of particular property by StationName in GameScene.sks
    /// getProperty is the function to accept statioName parametre and returns the property node
    /// - parameter stationName: the name of the station
    func getProperty(stationName: String) -> Property? {
        let stationNode = worldNode.childNode(withName: "routeMap")?.childNode(withName: stationName)!
        
        if (stationNode?.children.count)! > 0{
            let propertyNode = stationNode?.children.first as? Property
            //            propertyNode?.printDebug()
            return propertyNode
        } else {
            return nil
        }
    }
    
    
    ///this function helps to retrieve the Player by playerName =in GameScene.sks
    ///var player: Player = getPlayer(playerName: "pepe")
    /// - parameter playerName: the name of the player
    func getPlayer(playerName: String) -> Player? {
        let playerNode: Player? = self.worldNode.childNode(withName: playerName) as? Player
        return playerNode
    }
}

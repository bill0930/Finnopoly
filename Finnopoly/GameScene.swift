//
//  GameScene.swift
//  Finnopoly
//
//  Created by CHAN CHI YU on 22/10/2019.
//  Copyright © 2019 Finnopoly. All rights reserved.
//

import SpriteKit
import SwiftGraph


class GameScene: SKScene, UIPickerViewDataSource,UIPickerViewDelegate {
    //MARK: -PickerView for investment
     /***************************************************************/
    let pickerView = UIPickerView(frame: CGRect(x: 0, y: -130, width: 250, height: 300))
    let days: [String] = ["0", "1", "2", "3","4","5","6","7","8","9"]
    
    var row1:Int = 0
    var row2:Int = 0
    var row3:Int = 0
    var row4:Int = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Check")
        if component == 0{
            row1 = row
        }else if component == 1{row2 = row}
        else if component == 2{row3 = row}
        else if component == 3{row4 = row}
    }
    
    func pickerView(_ pickerView: UIPickerView,
      titleForRow row: Int, forComponent component: Int)
      -> String? {
        return days[row]
    }
    
    private func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) -> String{
           if component == 0 {
               row1 = row
               return days[row]
           }
           if component == 1 {
               row2 = row
               return days[row]
           }
           if component == 2 {
               row3 = row
                      return days[row]
                  }
           if component == 3 {
               row4 = row
                      return days[row]
           }else{
               return ""
           }
       }
    
    func test(prop: Property, playerInvest: Player){
        var a: String = ""
        var b: String = ""
        var c: String = ""
        var d: String = ""
        var result: Int = 0
        var a1: Int
        var b1: Int
        var c1: Int
        var d1: Int
        a = pickerView(pickerView, didSelectRow: row1, inComponent: 0)
        a1 = Int(a)!
        b = pickerView(pickerView, didSelectRow: row2, inComponent: 1)
        b1 = Int(b)!
        c = pickerView(pickerView, didSelectRow: row3, inComponent: 2)
        c1 = Int(c)!
        d = pickerView(pickerView, didSelectRow: row4, inComponent: 3)
        d1 = Int(d)!
        result = a1 * 1000 + b1 * 100 + c1 * 10 + d1
        self.propInvest(prop: prop, player: playerInvest, amount: Double(result))
        print(result)
    }
    
    //MARK: - global variable declaration
     /***************************************************************/
    var viewController: UIViewController!
    let serialQueue: DispatchQueue = DispatchQueue(label: "serialQueue")
    
    //    var diceNum: Int?
    var stationVertices : [String] = []
    var routeGraph: UnweightedGraph<String>!
    var worldNode: SKNode!
    var player: Player?
    
    var rollDiceBtnSprite : SKAControlSprite!
    var rollDiceForegroundSprite : RollDice!
    var rollDiceMask : RollDice!
    var toRoll = true
    var myMoves : Int = 0
    var pepeCam = SKNode()
    
    var quitBtnSprite : SKAControlSprite!
    var quitForegroundSprite : Quit!
    var quitMask : Quit!
    
    //test player
    var npc: Player?
    
    //hihihihihi
    func generateOriginalPrice() -> Double {
        // Generate Random Value
        // Current Original Price Range: $80~600
        let rand1 = Int.random(in: 0..<41), rand2 = Int.random(in: 1..<8), constant = 80
        let price = Double(rand2*constant+rand1)
        return price
    }
    
    
    func initProp() {
        // initialize maxInvestment & originalPrice of a prop
        // originalPrice is generated by random, by func generateOriginalPrice()
        // maxInvestment is generated by (consant*originalPrice) i.e. 5 times of originalPrice
        
        let maxConstant = 5.0 // Just a factor for setting max Investment
        for name in self.stationVertices {
            if let prop = self.getProperty(stationName: name){
                // setPrice of Each Node
                let newOriginalPrice = self.generateOriginalPrice()
                prop.setProperties(maxInvestment: maxConstant*newOriginalPrice, originalPrice: newOriginalPrice)
                // setLevel based on Price. Which should affect the display image of housing
                prop.setPropLevel()
                
            }
        }
        
        print("*********Success Prop initialization *************")
    }
    
    func initPlayer(){
        player = getPlayer(playerName: "Pepe")
        player?.walletAmount = 1000000
        move(node: player!, to: "brown1")
    }
    
    func initButton(){
        /********************************************************/
        // Button Display
        let cropNode = SKCropNode()
        cropNode.zPosition = 100
        cropNode.position = CGPoint(x: 0, y: 0)
        
        let maskNode = SKNode()
        maskNode.zPosition = 100
        cropNode.maskNode = maskNode
        
        pepeCam = (player?.childNode(withName: "PepeCamera"))!
        
        setupRollDiceButton(maskNode: maskNode, camera: pepeCam)
        setupQuitButton(maskNode: maskNode, camera: pepeCam)
        /********************************************************/
    }
    
    func initBgm (){
        // Background Music
        let bgm = SKAudioNode(fileNamed: "GameSceneBGM.mp3")
        self.addChild(bgm)
        bgm.run(SKAction.play())
    }
    
    //prompt a alert if there is two or more paths
    func alertNextMove(stations: [Station]){
        let alertController = UIAlertController(title: "Please select your next move", message: "You have \(player!.remainSteps) steps left", preferredStyle: .alert)
        
        
        for station in stations {
            alertController.addAction(UIAlertAction(title: "\(station.name!)",style: .default, handler: {
                (action: UIAlertAction!) in
                self.move(node: self.player!, to: station.name!)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.updatePlayerPosition(player: self.player!) //recursion
                }
            }))
        }
        
        self.viewController.present(alertController, animated: true, completion: nil)
        
    }
    
    func alertBuy(prop: Property, playerBuy: Player) {
        let alertController = UIAlertController(title: "\(prop.name!) meet!" ,message: "Do you want to spend $ \(Int(prop.originalPrice)) to buy \(prop.name!) ?", preferredStyle: .alert)
        
        // Yes Option
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            (action: UIAlertAction!) in
            self.propBuy(prop: prop, player: playerBuy)
            
        }))
        
        // No Option
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: {
            (action: UIAlertAction!) in
            print("No Buy Property \(prop.name!)")
        }))
        self.viewController.present(alertController, animated: true, completion: nil)
    }
    
    func propBuy(prop: Property, player: Player) {
        prop.owner = player.name!
        player.walletAmount! -= prop.originalPrice
        prop.setPropLevel() // Change Display image -> from house_0 to house_x
        print("*** System: Buy Complete *** \(player.name!) buys \(prop.name!)")
        print("**************************** Updated \(player.name!) 's wallet: \(player.walletAmount!)")
        
        prop.printDebug()
    }
    
    func alertInvest(prop: Property, playerInvest: Player) {
        
        // *** Data Validation: Max Investment not yet handle
        let vc = UIViewController()
        
        vc.preferredContentSize = CGSize(width: 250,height: 100)
        pickerView.dataSource = self
        pickerView.delegate = self
        vc.view.addSubview(pickerView)
        let editRadiusAlert = UIAlertController(title: "\(prop.name!) meet!" ,message: "Do you want to invest \(prop.name!) ? \n Your maximum investment is \(prop.maxInvestment)", preferredStyle: UIAlertController.Style.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(action: UIAlertAction!) in self.test(prop: prop, playerInvest: playerInvest)}))
        editRadiusAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.viewController.present(editRadiusAlert, animated: true)
    }
    
    func propInvest(prop: Property, player: Player, amount: Double) {
       // print(player.walletAmount!)
      //  player.walletAmount = 1000
        if prop.maxInvestment >= amount && player.walletAmount! >= amount{
      //  print("done")
        prop.curInvestment += amount
        player.walletAmount! -= amount
        prop.setPropLevel() // change display image from house_a to house_b based on investment
        print("*** System: Invest Complete *** \(player.name!) invests \(prop.name!)")
        print("**************************** Updated \(player.name!) 's wallet: \(player.walletAmount!)")
            prop.printDebug()
        }else if prop.maxInvestment < amount {
        //    print("Maxin")
            let alertmax = UIAlertController(title: "Over Max Investment", message: nil, preferredStyle: .alert)
            alertmax.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (action: UIAlertAction!) in
                self.alertInvest(prop: prop, playerInvest: player)
            }))
                    self.viewController.present(alertmax, animated: true)
        }else if player.walletAmount! < amount{
        //    print("nomoney")
            let alertmon = UIAlertController(title: "Not enough money", message: nil, preferredStyle: .alert)
            alertmon.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (action: UIAlertAction!) in
                self.alertInvest(prop: prop, playerInvest: player)
            }))
                    self.viewController.present(alertmon, animated: true)
        }
    }
    
    func alertToll(prop: Property, playerPay: Player, playerReceive: Player) {
        let alertController = UIAlertController(title: "\(prop.name!) meet!" ,message: "You need to pay \(Int(prop.tollPrice)) to \(playerReceive.name!)!", preferredStyle: .alert)
        
        //
        alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: {
            (action: UIAlertAction!) in
            self.propPayToll(prop: prop, payer: playerPay, receiver: playerReceive )
            
        }))
        
        self.viewController.present(alertController, animated: true, completion: nil)
    }
    
    func propPayToll(prop: Property, payer: Player, receiver: Player) {
        payer.walletAmount! -= prop.tollPrice
        //receiver.walletAmount! += prop.tollPrice
        print("*** System: Pay Toll Complete *** \(payer.name!) pay \(prop.tollPrice) to \(receiver.name!)")
        print("**************************** Updated \(payer.name!) 's wallet: \(payer.walletAmount!)")
        receiver.walletAmount! += prop.tollPrice
        print("**************************** Updated \(receiver.name!) 's wallet: \(receiver.walletAmount!)")
    }
    
    //MARK: - GameStart
     /***************************************************************/
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        worldNode = self
        getCityGraph()
        initProp()
        initPlayer()
        initButton()
        initBgm()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        diceNum = 1
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        super.update(currentTime)
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
        let moveAction = SKAction.move(to: newPos, duration: 1.0)
        moveAction.timingMode = .easeOut
        node.run(moveAction)
        //assignment the currentStation
        node.previousStation = node.currentStation
        node.currentStation = station
        if player!.remainSteps > 0 {
            player!.remainSteps -= 1
        }
    }
    
    ///this function helps to transverse the all properties
    func tranverseProperties (){
        print("-----Printing all propertie name -----")
        for name in stationVertices {
            
            if let prop = getProperty(stationName: name){
                print("*****************")
                prop.printDebug()
            }
        }
    }
    
    ///this function helps to update the player position according to the
    func updatePlayerPosition(player: Player){
        if player.remainSteps == 0 {
            if let prop = getProperty(stationName: player.currentStation!){
                if prop.owner == "" {
                    alertBuy(prop: prop, playerBuy: player)
                }
                else if prop.owner == player.name! {
                    // Below alert supposed to be alert with textfield or picker. But no time to examine how to do it currently
                    // therefore just use multiple choice for testing investment first
                    alertInvest(prop: prop, playerInvest: player)
                }
                
                else if prop.owner != player.name! {
                    // How to generate a new player?
                    // Change below second player to another one. dont know how to make new player
                    // E.g. player 2 = derek pao -> receiver = derek pao player, which is the owner of that prop
                    alertToll(prop: prop, playerPay: player, playerReceive: player)
                }
            }
            //IC station for Q&A
            else if (player.currentStation?.contains("IC"))!{
                //code for interchange station
                print("This is an Interchange Station")
            }
        }
        
        if player.remainSteps > 0 {
            let adjStation = getAdjacentStation(stationName: player.currentStation!)
            if adjStation.count == 1 {
                self.move(node: player, to: adjStation[0].name!)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.updatePlayerPosition(player: player) //recursion
                }
            } else if adjStation.count > 1 {
                alertNextMove(stations: adjStation)
                
            }
        }
        
    }
    
    //MARK: - Some Getter for Station, Property and Player by their stationName or playerName in the GameScene
    /***************************************************************/
    
    ///this function helps to retrieve the station of by StationName in GameScene.sks
    /// getStation is the function to accept statioName parametre and returns the Station node
    /// - parameter stationName: the name of the station
    func getStation(stationName: String) -> Station?{
        let stationNode = worldNode.childNode(withName: "routeMap")!.childNode(withName: stationName)!
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
    
    func getAdjacentStation(stationName: String) -> [Station]{
        let stringArray = routeGraph.neighborsForVertex(stationName)?.filter({$0 != player?.previousStation})
        //        print(stringArray.debugDescription)
        let mappedArray = stringArray?.map({getStation(stationName: $0)!})
        //        print(mappedArray.debugDescription)
        return mappedArray!
    }
    
    //MARK: - Some Setter for buttons
    /***************************************************************/
    /// set up the roll dice button and add its related actions (i.e, touchUpInside, touchDown)
    /// - parameter maskNode: SKNode
    func setupRollDiceButton(maskNode: SKNode, camera: SKNode)
    {
        rollDiceBtnSprite = SKAControlSprite(color: .clear, size: CGSize(width: 50, height: 50))
        
        // let the button be related to the camera view
        let bottomLeftView = CGPoint(x: 50, y: view!.frame.height + 300)
        rollDiceBtnSprite.position = convertPoint(fromView: bottomLeftView)
        rollDiceBtnSprite.zPosition = 1000
        camera.addChild(rollDiceBtnSprite)
        
        // set the action for certain events
        rollDiceBtnSprite.addTarget(self, selector: #selector(rollDiceButtonTouchDown), forControlEvents: [.TouchDown, .DragEnter])
        rollDiceBtnSprite.addTarget(self, selector: #selector(rollDiceButtonTouchUpInside), forControlEvents: [.TouchUpInside])
        
        rollDiceMask = RollDice(size: rollDiceBtnSprite.size, frame: frame)
        rollDiceMask.position = rollDiceBtnSprite.position
        
        rollDiceForegroundSprite = RollDice(size: rollDiceBtnSprite.size, frame: frame)
        rollDiceForegroundSprite.position = rollDiceBtnSprite.position
        
        maskNode.addChild(rollDiceMask)
        camera.addChild(rollDiceForegroundSprite)
    }
    
    func setupQuitButton(maskNode: SKNode, camera: SKNode)
    {
        quitBtnSprite = SKAControlSprite(color: .clear, size: CGSize(width: 50, height: 50))
        
        // let the button be related to the camera view
        let upLeftView = CGPoint(x: 0, y: view!.frame.height - 300)
        quitBtnSprite.position = convertPoint(fromView: upLeftView)
        quitBtnSprite.zPosition = 1000
        camera.addChild(quitBtnSprite)
        
        // set the action for certain events
        quitBtnSprite.addTarget(self, selector: #selector(quitButtonTouchDown), forControlEvents: [.TouchDown, .DragEnter])
        quitBtnSprite.addTarget(self, selector: #selector(quitButtonTouchUpInside), forControlEvents: [.TouchUpInside])
        
        quitMask = Quit(size: quitBtnSprite.size, frame: frame)
        quitMask.position = quitBtnSprite.position
        
        quitForegroundSprite = Quit(size: quitBtnSprite.size, frame: frame)
        quitForegroundSprite.position = quitBtnSprite.position
        
        maskNode.addChild(quitMask)
        camera.addChild(quitForegroundSprite)
    }
    
    @objc func rollDiceButtonTouchDown()
    {
        if toRoll
        {
            rollDiceForegroundSprite.setPressed()
            rollDiceMask.setPressed()
        }
    }
    
    @objc func rollDiceButtonTouchUpInside()
    {
        if toRoll
        {
            myMoves = rollDiceForegroundSprite.rollDice()
            print("Dice Result: \(myMoves) \n#################")
            player?.remainSteps = myMoves
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.serialQueue.sync {
                    self.updatePlayerPosition(player: self.player!)
                }
            }
            
            rollDiceMask.setReleased()
        }
        //        toRoll = false
    }
    
    @objc func quitButtonTouchDown()
    {
        quitForegroundSprite.setPressed()
        quitMask.setPressed()
    }
    
    @objc func quitButtonTouchUpInside()
    {
        quitForegroundSprite.setReleased()
        quitMask.setReleased()
        print("Quit Button Pressed \n#####################")
    }
    
}


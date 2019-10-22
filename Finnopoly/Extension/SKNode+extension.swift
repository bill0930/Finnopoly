//
//  SKNode+extension.swift
//  Finnopoly
//
//  Created by CHAN CHI YU on 23/10/2019.
//  Copyright © 2019 Finnopoly. All rights reserved.
//

import SpriteKit
extension SKNode {

//unarchive a sks file then turn it to a Node
class func unarchiveFromFile(file: String) -> SKNode? {
    if let path = Bundle.main.path(forResource:file, ofType: "sks"){
        let url = URL(fileURLWithPath: path)
        do{
            let sceneData = try Data(contentsOf: url, options: .mappedIfSafe)
            let archiver =  try NSKeyedUnarchiver(forReadingFrom: sceneData)
            archiver.requiresSecureCoding = false
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! SKNode
            archiver.finishDecoding()
            return scene
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
    }else {
        return nil
    }
}
}

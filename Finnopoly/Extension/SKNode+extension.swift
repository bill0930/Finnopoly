//
//  SKNode+extension.swift
//  Finnopoly
//
//  Created by CHAN CHI YU on 23/10/2019.
//  Copyright © 2019 Finnopoly. All rights reserved.
//

import SpriteKit
extension SKNode {
    
    /// unarchiveFromFile is the function to accept  sks file parametre and add it into the scene and become a SKNode
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
    
    /// getCountWithName is the function to accept name parametre and returns the child node count with that name inclusive
    /// e.g if the node testNode has children node of brown0, brown1, brown2, testNode.getCountWithName(withName: "brown") will return 3
    /// - parameter name: the string to be count,
    func getCountWithName(withName name: String?) -> Int{
        var count: Int = 0
        self.enumerateChildNodes(withName: "*\(name!)*"){
            node, _ in
            count = count + 1
        }
        return count
    }


}

extension UIApplication {
    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(viewController: nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(viewController: selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(viewController: presented)
        }
        return viewController
    }
}

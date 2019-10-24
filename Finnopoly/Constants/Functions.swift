//
//  Functions.swift
//  Finnopoly
//
//  Created by CHAN CHI YU on 23/10/2019.
//  Copyright © 2019 Finnopoly. All rights reserved.
//

import Foundation
import SpriteKit

//scalar operation
public func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x , y: left.y + right.y )
}

public func += (left: inout CGPoint, right: CGPoint) {
        left = left + right
}



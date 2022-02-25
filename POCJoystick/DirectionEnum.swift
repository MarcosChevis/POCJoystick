//
//  DirectionEnum.swift
//  POCJoystick
//
//  Created by Marcos Chevis on 23/02/22.
//

import Foundation
import CoreGraphics

enum Direction: String, CaseIterable {
    case top
    case bot
    case left
    case right
    
    var point: CGPoint {
        switch self {
        case .top:
            return CGPoint(x: 0, y: -1)
        case .bot:
            return CGPoint(x: 0, y: 1)
        case .left:
            return CGPoint(x: -1, y: 0)
        case .right:
            return CGPoint(x: 1, y: 0)
        }
    }
    
    static func getRandomPoint() -> CGPoint {
        return (Direction.allCases.randomElement() ?? .top).point
    }
    
    static prefix func !(op: Direction) -> Direction {
        switch op {
            case top:
                return self.bot
            case .bot:
                return self.top
            case .left:
                return self.right
            case .right:
                return self.left
        }
    }
}

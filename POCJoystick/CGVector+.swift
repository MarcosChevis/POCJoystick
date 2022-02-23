//
//  CGVector+.swift
//  POCJoystick
//
//  Created by Marcos Chevis on 23/02/22.
//

import Foundation
import CoreGraphics

extension CGVector {
    
    static func *(lhs: CGVector, rhs: CGFloat) -> CGVector {
        
        var vector: CGVector = .zero
        
        vector.dx = lhs.dx * rhs
        vector.dy = lhs.dy * rhs
        
        return vector
    }
    
    public static func +(lhs: CGVector, rhs: CGVector) -> CGVector {
        return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
    }
    
    public func magnitude() -> CGFloat {
        if dx == CGFloat.zero && dy == CGFloat.zero {
            return CGFloat.zero
        }
        return sqrt((pow(dx, 2) + pow(dy, 2)))
    }
    
    public func normalized() -> CGVector {
        let magnitude = self.magnitude()
        guard magnitude > 0 else { return .zero }
        var vector = CGVector.zero
        vector.dx = self.dx / magnitude
        vector.dy = self.dy / magnitude
        
        return vector
    }
    
    public func getRadAngle() -> CGFloat {
        return atan(dy/dx)
    }
    
   
}


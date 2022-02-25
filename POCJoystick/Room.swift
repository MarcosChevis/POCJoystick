//
//  Room.swift
//  POCJoystick
//
//  Created by Marcos Chevis on 23/02/22.
//

import Foundation

struct Room: Hashable {
    
    let possibleDirections: [Direction]
    
    init(possibleDirections: [Direction]) {
        self.possibleDirections = possibleDirections
    }
    
}

//extension Room: CustomStringConvertible {
//    var description: String {
//        return ""
//    }
//}

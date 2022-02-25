//
//  Room.swift
//  POCJoystick
//
//  Created by Marcos Chevis on 23/02/22.
//

import Foundation

struct Room: Hashable {
    
    let possibleDirections: [Direction]
    
    let index: Int
    
    init(index: Int, possibleDirections: [Direction]) {
        self.index = index
        self.possibleDirections = possibleDirections
    }
    
    static func == (lhs: Room, rhs: Room) -> Bool {
        return lhs.index == rhs.index
    }
}

extension Room: CustomStringConvertible {
    var description: String {
        return "\(self.index)"
    }
    
    
}

struct Exit {
    var room: Room
    var direction: Direction
}

extension Exit: CustomStringConvertible {
    
    var description: String {
        var string = ""
        switch direction {
        case .top:
            string = "↑"
        case .bot:
            string = "↓"
        case .left:
            string = "←"
        case .right:
            string = "→"
        }
        
        return string + room.description
    }
    
    
}

//
//  DunfeonGenerator.swift
//  POCJoystick
//
//  Created by Marcos Chevis on 23/02/22.
//

import Foundation
import SpriteKit

class DungeonGenerator {
    var matrix: [[Int]] = []
    var roomService = RoomService()
    
    func getMap(totalRooms: Int) {
        self.matrix = generateMatrix(totalRooms: totalRooms)
        printMatrix(matrix: matrix)
    }
    
    private func generateMatrix(totalRooms: Int) -> [[Int]] {
        
        let matrixSize = totalRooms
        var matrix: [[Int]] = Array(repeating: Array(repeating: -1, count: matrixSize), count: matrixSize)
        
        var lastDir = Direction.top
        var currentPos = CGPoint(x: (matrixSize+1)/2, y: (matrixSize+1)/2)
        
        var count: Int = 0
        
        while count < totalRooms {
            let room = roomService.getRandomRoom(lastDirection: lastDir)
            let direction = getRandomDirection(currentPosition: currentPos, totalRooms: totalRooms, lastDirection: lastDir, possibleDirections: room.possibleDirections)
            
            currentPos += direction.point
            lastDir = direction
            
            if matrix[currentPos.intX][currentPos.intY] == -1 {
                matrix[currentPos.intX][currentPos.intY] = count
                count += 1
            }
        }
        
        return matrix
    }
    
    private func getRandomDirection(currentPosition: CGPoint, totalRooms: Int, lastDirection: Direction, possibleDirections: [Direction]) -> Direction {
        var direction = possibleDirections.randomElement() ?? possibleDirections[0]
        
        while isDirectionInValid(currentPosition: currentPosition, totalRooms: totalRooms, lastDirection: lastDirection.point, direction: direction.point) {
            direction = possibleDirections.randomElement() ?? possibleDirections[0]
        }
        
        return direction
    }
    
    private func isDirectionInValid(currentPosition: CGPoint, totalRooms: Int, lastDirection: CGPoint, direction: CGPoint) -> Bool {
        let isRoomXAxisOutOfBounds = currentPosition.intX + direction.intX >= totalRooms || currentPosition.intX + direction.intX < 0
        let isRoomYAxisOutOfBounds = currentPosition.intY + direction.intY >= totalRooms || currentPosition.intY + direction.intY < 0
        let isDirectionInvertOfPrevious = direction == lastDirection * -1
        
        return isRoomXAxisOutOfBounds || isRoomYAxisOutOfBounds || isDirectionInvertOfPrevious
    }
    
    private func generateMatrixSize(_ totalRooms: Int) -> Int {
        if totalRooms % 2 == 0 {
            return totalRooms + 1
        } else {
            return totalRooms + 2
        }
    }
    
    private func printMatrix(matrix: [[Int]]) {
        var string = ""
        
        for line in matrix {
            string += "["
            for item in line {
                if item < 0 {
                    string += "  "
                } else if item >= 0 && item < 10 {
                    string += " \(item)"
                } else if item >= 10 {
                    string += "\(item)"
                }
                string += " "
            }
            string += "]\n"
        }
        print(string)
    }
    
}

class RoomService {
    var rooms: [Room] = [Room(possibleDirections: Direction.allCases),
                         Room(possibleDirections: [.top, .bot]),
                         Room(possibleDirections: [.bot, .left]),
                         Room(possibleDirections: [.left, .right]),
                         Room(possibleDirections: [.right, .top])
                        ]
    
    func getRandomRoom(lastDirection: Direction) -> Room {
        let filteredRooms = rooms.filter { room in
            room.possibleDirections.contains(!lastDirection)
        }
        return filteredRooms.randomElement() ?? rooms[0]
    }
}





extension CGPoint {
    static func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        var p = CGPoint(x: lhs.x, y: lhs.y)
        p.x *= rhs
        p.y *= rhs
        return p
    }
    
    static func +=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs.y += rhs.y
        lhs.x += rhs.x
    }
    
    var intX: Int {
        return Int(x)
    }
    
    var intY: Int {
        return Int(y)
    }
}

//
//  DunfeonGenerator.swift
//  POCJoystick
//
//  Created by Marcos Chevis on 23/02/22.
//

import Foundation
import SpriteKit

class DungeonGenerator {
    var matrix: [[Int]] = [[-1, -1, -1], [-1, 0, -1], [-1, 1, -1]]
//    var graph: [Room: [Exit]] = [:]
//    var probability: Int = 5
    
    func getMap(totalRooms: Int) {
        self.matrix = generateMatrix(totalRooms: totalRooms)
        printMatrix(matrix: matrix)
        //createGraphFromMatrix(totalRooms: totalRooms)
    }
    
    //vai da problema se ele da uma volta e coloca um numero desconectado do anterior
    //
//    func createGraphFromMatrix(totalRooms: Int) {
//        var currentPos: CGPoint = CGPoint(x: matrix.count/2, y: matrix.count/2)
//        var count = 1
//
//        var currentRoom = Room(index: 0)
//        graph[currentRoom] = []
//
//        while count < totalRooms {
//
//            var newRoom: Room?
//            var direction: Direction = .bot
//            var newPos = CGPoint(x: currentPos.x, y: currentPos.y - 1)
//
//            //se newPos for dentro da Matriz e Matriz[newPos] != -1
//            if newPos.intX < matrix.count && newPos.intY < matrix.count && newPos.intX >= 0 && newPos.intY >= 0 && matrix[newPos.intX][newPos.intY] != -1 {
//
//                //se a diferença de Matriz[newPos] e Matriz[currentPos] == 1
//                if (matrix[newPos.intX][newPos.intY] - matrix[currentPos.intX][currentPos.intY]).magnitude == 1 {
//                    //cria nova sala
//                    newRoom = Room(index: matrix[newPos.intX][newPos.intY])
//
//                    //verifica se há uma sala com o index de newRoom com saídas diferente de nulo. Implica que nenhuma sala eh criada e continua com as saídas nula.
//                    if graph[newRoom!] == nil {
//                        //cria vetor de saídas vazio
//                        graph[newRoom!] = []
//                    } else {
//                        //caso já tenha sido criada a sala de index x, pega a instancia dela do gráfico
//                        newRoom = graph.keys.first { roomInGraph in
//                            newRoom == roomInGraph
//                        }
//                    }
//
//                    //Adiciona saída da currentRoom em direção a newRoom
//                    graph[currentRoom]?.append(Exit(room: newRoom!, direction: direction))
//                    //Atualiza currentPos para newPos
//                    currentPos = CGPoint(x: newPos.x, y: newPos.y)
//
//                //se a diferença Matrix[currentPos] e Matrix[newPos] < -1
//                } else if (matrix[currentPos.intX][currentPos.intY] - matrix[newPos.intX][newPos.intY]) < -1 {
//
//                    //cria nova sala
//                    //antes de criar precisa verificar se ela já existe
//                    newRoom = Room(index: matrix[newPos.intX][newPos.intY])
//                    //cria zerada as sídas dessa sala
//                    graph[newRoom!] = []
//                    //decide com uma chance x se vai criar uma conexão
//                    let random = Int.random(in: 0..<10)
//                    if random < probability {
//                        //cria a conxão da currentRoom pra newRoom
//                        graph[currentRoom]?.append(Exit(room: newRoom!, direction: direction))
//                    }
//
//                //se a diferença Matrix[currentPos] e Matrix[newPos] > 1 e existir uma conexão de graph[newPos] para graph[currentPos] na !direction
//                } else if (matrix[currentPos.intX][currentPos.intY] - matrix[newPos.intX][newPos.intY]) > 1 && graph[Room(index: matrix[newPos.intX][newPos.intY])]!.contains(where: { exit in
//                    return exit.room == currentRoom && exit.direction == !direction
//                }) {
//
//                    //se existe uma sala com o index = Matrix[currentPos]
//                    if let futureRoom = graph.keys.first(where: { roomInGraph in
//                        roomInGraph == Room(index: matrix[currentPos.intX][currentPos.intY])
//                    }) {
//                        //conectar graph[currentPos] com graph[newPos] na direction
//                        graph[currentRoom]?.append(Exit(room: futureRoom, direction: direction))
//                    }
//                }
//            }
//
//            count += 1
//            //atualiza a sala atual, soh deve acontecer depois de todos os lados terem sido verificados
//            currentRoom = newRoom ?? currentRoom
//        }
//        for i in graph {
//            print(i)
//        }
//        print("")
//        print("----------------")
//
//
//    }
    
    //começa verificacao pra baixo
//            var newRoom: Room?
//
//            if matrix[currentPos.intX][currentPos.intY + 1] == -1 {
//                //nada
//            } else if (matrix[currentPos.intX][currentPos.intY + 1] - matrix[currentPos.intX][currentPos.intY]).magnitude == 1 {
//                newRoom = Room(index: count)
//                if graph[newRoom!] == nil {
//                    graph[newRoom!] = []
//                }
//                graph[currentRoom]?.append(Exit(room: newRoom!, direction: .bot))
//                currentPos = CGPoint(x: currentPos.x, y: currentPos.y + 1)
//            } else if (matrix[currentPos.intX][currentPos.intY + 1] - matrix[currentPos.intX][currentPos.intY]) < -1{
//                newRoom = Room(index: matrix[currentPos.intX][currentPos.intY + 1])
//                graph[newRoom!] = []
//                let random = Int.random(in: 0..<10)
//                if random < probability {
//                    graph[currentRoom]?.append(Exit(room: newRoom!, direction: .bot))
//                }
//
//            }
    
    //termina verificacao pra baixo

//    func verifySide(_ direction: Direction, position currentPos: CGPoint, room currentRoom: Room, count: Int) -> (CGPoint, Room, Room?) {
//        var newRoom: Room?
//        var currentPos = currentPos
//        let newPos: CGPoint
//
//        switch direction {
//        case .top:
//            newPos = CGPoint(x: currentPos.x, y: currentPos.y - 1)
//        case .bot:
//            newPos = CGPoint(x: currentPos.x, y: currentPos.y + 1)
//        case .left:
//            newPos = CGPoint(x: currentPos.x - 1, y: currentPos.y)
//        case .right:
//            newPos = CGPoint(x: currentPos.x + 1, y: currentPos.y)
//        }
//
//        if newPos.intX < matrix.count && newPos.intY < matrix.count && newPos.intX >= 0 && newPos.intY >= 0 && matrix[newPos.intX][newPos.intY] != -1 {
//
//            if matrix[newPos.intX][newPos.intY] == -1 { //verificar se ta dentro da matriz
//                //nada
//            } else if (matrix[newPos.intX][newPos.intY] - matrix[currentPos.intX][currentPos.intY]).magnitude == 1 {
//                newRoom = Room(index: matrix[newPos.intX][newPos.intY])
//                if graph[newRoom!] == nil {
//                    graph[newRoom!] = []
//                }
//                graph[currentRoom]?.append(Exit(room: newRoom!, direction: .bot))
//                currentPos = CGPoint(x: currentPos.x, y: currentPos.y + 1)
//            } else if (matrix[newPos.intX][newPos.intY] - matrix[currentPos.intX][currentPos.intY]) < -1{
//                newRoom = Room(index: matrix[newPos.intX][newPos.intY])
//                graph[newRoom!] = []
//                let random = Int.random(in: 0..<10)
//                if random < probability {
//                    graph[currentRoom]?.append(Exit(room: newRoom!, direction: .bot))
//                }
//            }
//        }
//        return (currentPos, currentRoom, newRoom)
//    }
    
    
    private func generateMatrix(totalRooms: Int) -> [[Int]] {
        
        let matrixSize = generateMatrixSize(totalRooms)
        var matrix: [[Int]] = Array(repeating: Array(repeating: -1, count: matrixSize), count: matrixSize)
        let directions: [CGPoint] = Direction.allCases.map(\.point)
        
        var lastDir = directions[1]
        var currentPos = CGPoint(x: (matrixSize+1)/2, y: (matrixSize+1)/2)
        
        var count: Int = 0
        
        while count < totalRooms {
            
            let direction = getRandomDirection(currentPosition: currentPos, totalRooms: totalRooms, lastDirection: lastDir)

            currentPos += direction
            lastDir = direction
            
            if matrix[currentPos.intX][currentPos.intY] == -1 {
                matrix[currentPos.intX][currentPos.intY] = count
                count += 1
            }
        }
        return matrix
    }
    
    private func getRandomDirection(currentPosition: CGPoint, totalRooms: Int, lastDirection: CGPoint, possibleDirections: [Direction]) -> CGPoint{
        var direction = Direction.getRandomPoint()

        while isDirectionInValid(currentPosition: currentPosition, totalRooms: totalRooms, lastDirection: lastDirection, direction: direction) {
            direction = Direction.getRandomPoint()
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
                if item >= 0 {
                    string += " "
                }
                string += " \(item)"
            }
            string += "]\n"
        }
        print(string)
    }
    
}

class RoomService {
    
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

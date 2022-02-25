//
//  GameScene.swift
//  POCJoystick
//
//  Created by Marcos Chevis on 22/02/22.
//

import SpriteKit
import GameplayKit
import GameController

class GameScene: SKScene {
    let dungeonCreator: DungeonGenerator = .init()
    
    func setupScene() {
        dungeonCreator.getMap(totalRooms: 10)
    }
    
    override func didMove(to view: SKView) {
        self.setupScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dungeonCreator.getMap(totalRooms: 10)
        
    }
}

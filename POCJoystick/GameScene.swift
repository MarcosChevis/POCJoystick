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
    
    private var circle: SKShapeNode?
    private var initialPosition: CGPoint?
    
    var joystickController: JoystickController = JoystickController()
    var lastActionTiem: TimeInterval = .zero
    let waitBorNextAction: Double = 1
    
    func setupScene() {
        joystickController.delegate = self
        joystickController.observeForGameControllers()
        physicsWorld.gravity = .zero
        createCircle()
    }
    
    func createCircle() {
        
    }
    
    override func didMove(to view: SKView) {
        self.setupScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        joystickController.update(currentTime)
    }
    

}

extension GameScene: JoystickDelegate {
    
    func rightJoystickUpdate(_ currentTime: TimeInterval) {
        
        if let gamePadRight = joystickController.gamePadRight {
            print(gamePadRight.xAxis.value, gamePadRight.yAxis.value)
        }
    }
    
    func leftJoystickUpdate(_ currentTime: TimeInterval) {
        
        if let gamePadLeft = joystickController.gamePadLeft {
            print(gamePadLeft.xAxis.value, gamePadLeft.yAxis.value)
        }
    }
    
    func controllerDidConnect(controller: GCController) {
        print("connected")
    }
    
    func controllerDidDisconnect() {
        print("disconnected")
    }
}

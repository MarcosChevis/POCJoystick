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
    
    private var circle: SKSpriteNode = SKSpriteNode(imageNamed: "alien.jpeg")
    private var initialPosition: CGPoint?
    //multiplicador de força do joysick
    private var joystickMult: CGFloat = 1000
    private let cam = SKCameraNode()
    
    var joystickController: JoystickController = JoystickController()
    var lastActionTiem: TimeInterval = .zero
    let waitBorNextAction: Double = 1
    
    //vetor que vai ser mudado e zerado todo update
    var forceVector: CGVector = .zero
    
    func setupScene() {
        joystickController.delegate = self
        joystickController.observeForGameControllers()
        physicsWorld.gravity = .zero
        createCircle()
    }
    
    func createCircle() {
        
        
        self.circle.size = .init(width: 200, height: 200)
        self.circle.physicsBody = .init(circleOfRadius: 10)
        self.circle.physicsBody?.mass = 1
        self.circle.position = .init(x: 10, y: 10)
        
        
    }
    
    override func didMove(to view: SKView) {
        self.addChild(circle)
        //a camera da cena vira a que instanciei no comeco
        self.camera = cam
        self.setupScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        //forças são aplicadas no objeto
        joystickController.update(currentTime)
        applyFriction()
        print(forceVector)
        //aplica a força no corpo
        self.circle.physicsBody?.applyForce(forceVector)
        //reseta o vetor de força
        forceVector = .zero
    }
    override func didSimulatePhysics() {
        //atualiza a posiçao da camera quando termina de calcular a física
        self.cam.position = self.circle.position
    }
    
    func applyFriction() {
        let coefficient: CGFloat = 2
  
        self.forceVector = self.forceVector + (self.forceVector.normalized() * -coefficient)
    }
    
    func applyJoystickForce(_ normalForce: CGVector) {
        self.forceVector = self.forceVector + (normalForce * joystickMult)
    }
    
}

extension GameScene: JoystickDelegate {
    func rightJoystickUpdate(_ currentTime: TimeInterval, direction: CGVector) {
        var angle = direction.getRadAngle()

        if direction.dx < 0 {
            angle = angle + (CGFloat.pi)
        }
        
        let action = SKAction.rotate(toAngle: angle, duration: 0)
        self.circle.run(action)
        
    }
    
    func leftJoystickUpdate(_ currentTime: TimeInterval, direction: CGVector) {
        applyJoystickForce(direction)
        
    }
    
    func controllerDidConnect(controller: GCController) {
        print("connected")
    }
    
    func controllerDidDisconnect() {
        print("disconnected")
    }
}


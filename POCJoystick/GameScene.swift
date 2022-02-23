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
    private var joystickMult: CGFloat = 1000
    private let cam = SKCameraNode()
    
    var joystickController: JoystickController = JoystickController()
    var lastActionTiem: TimeInterval = .zero
    let waitBorNextAction: Double = 1
    
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
        self.camera = cam
        self.setupScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        joystickController.update(currentTime)
        applyFriction()
        print(forceVector)
        self.circle.physicsBody?.applyForce(forceVector)
        forceVector = .zero
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


//
//  JoystickController.swift
//  POCJoystick
//
//  Created by Marcos Chevis on 22/02/22.
//

import Foundation
import SpriteKit
import GameController

class JoystickController {
    weak var delegate: JoystickDelegate?
    
    var gamePadRight: GCControllerDirectionPad?
    var gamePadLeft: GCControllerDirectionPad?
    
    private var _virtualController: Any?
    
    public var virtualController: GCVirtualController? {
        get { return self._virtualController as? GCVirtualController }
        set { self._virtualController = newValue }
    }
    
    
    func observeForGameControllers() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.handleControllerDidConnect),
            name: NSNotification.Name.GCControllerDidBecomeCurrent, object: nil)
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.handleControllerDidDisconnect),
            name: NSNotification.Name.GCControllerDidStopBeingCurrent, object: nil)
        
        let virtualConfiguration = GCVirtualController.Configuration()
        
        // crie um array com os elementos que escolheu nas variáveis globais
        virtualConfiguration.elements = [GCInputLeftThumbstick, GCInputRightThumbstick]
        
        virtualController = GCVirtualController(configuration: virtualConfiguration)
        
        // Connect to the virtual controller if no physical controllers are available.
        if GCController.controllers().isEmpty {
            virtualController?.connect()
        }
        
        guard let controller = GCController.controllers().first else {
            return
        }
        registerGameController(controller)
    }
    
    @objc
    func handleControllerDidConnect(_ notification: Notification) {
        guard let gameController = notification.object as? GCController else {
            return
        }
        unregisterGameController()
        
        
        if gameController != virtualController?.controller {
            virtualController?.disconnect()
        }
        registerGameController(gameController)
        
        delegate?.controllerDidConnect(controller: gameController)
    }
    
    @objc
    func handleControllerDidDisconnect(_ notification: Notification) {
        unregisterGameController()
        delegate?.controllerDidDisconnect()
        
        if GCController.controllers().isEmpty {
            virtualController?.connect()
        }
    }
    
    func registerGameController(_ gameController: GCController) {
        
        // para mudar a cor do led do controle de PS4
        // gameController.light?.color = GCColor(red: 0.5, green: 0.5, blue: 0.5)
        
        if let gamepad = gameController.extendedGamepad {
            self.gamePadLeft = gamepad.leftThumbstick
            self.gamePadRight = gamepad.rightThumbstick
        }
    }
    
    func unregisterGameController() {
        gamePadLeft = nil
    }
    
    func update(_ currentTime: TimeInterval) {
        updateRight(currentTime)
        updateLeft(currentTime)
    }
    
    func updateRight(_ currentTime: TimeInterval) {
        guard let gamePadRight = gamePadRight else {
            return
        }
        let vector = CGVector(dx: CGFloat(gamePadRight.xAxis.value), dy: CGFloat(gamePadRight.yAxis.value))
        
        delegate?.rightJoystickUpdate(currentTime, direction: vector)
    }
    
    func updateLeft(_ currentTime: TimeInterval) {
        guard let gamePadLeft = gamePadLeft else {
            return
        }
        let vector = CGVector(dx: CGFloat(gamePadLeft.xAxis.value), dy: CGFloat(gamePadLeft.yAxis.value))
        
        delegate?.leftJoystickUpdate(currentTime, direction: vector)
    }
    
}

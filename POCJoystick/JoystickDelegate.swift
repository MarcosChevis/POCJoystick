//
//  JoystickDelegate.swift
//  POCJoystick
//
//  Created by Marcos Chevis on 22/02/22.
//

import Foundation
import GameController

protocol JoystickDelegate: AnyObject {
    func rightJoystickUpdate(_ currentTime: TimeInterval, direction: CGVector)
    func leftJoystickUpdate(_ currentTime: TimeInterval, direction: CGVector)
    func controllerDidConnect(controller: GCController)
    func controllerDidDisconnect()
}

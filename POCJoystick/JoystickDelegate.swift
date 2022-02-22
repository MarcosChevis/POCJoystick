//
//  JoystickDelegate.swift
//  POCJoystick
//
//  Created by Marcos Chevis on 22/02/22.
//

import Foundation
import GameController

protocol JoystickDelegate: AnyObject {
    func rightJoystickUpdate(_ currentTime: TimeInterval)
    func leftJoystickUpdate(_ currentTime: TimeInterval)
    func controllerDidConnect(controller: GCController)
    func controllerDidDisconnect()
}

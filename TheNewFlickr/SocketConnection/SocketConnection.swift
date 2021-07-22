//
//  SocketConnection.swift
//  ASK
//
//  Created by Ahmed Elmemy on 06/04/2021.
//

import Foundation
import SocketIO


open class SocketConnection {
    
    public static let sharedInstance = SocketConnection()
    let manager: SocketManager
    public var socket: SocketIOClient
    let url = URLs.BASE + ":" + URLs.port
    
    
    private init() {
        
         manager = SocketManager(socketURL: URL(string: url)!, config: [.log(true), .compress])

        socket = manager.defaultSocket
    }
}

//
//  SocketIOManager.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/23.
//

import Foundation
import SocketIO

final class SocketIoManager: NSObject {
	
	static let shared = SocketIoManager()
	
	var manager: SocketManager!
	var socket: SocketIOClient!
	
	let uid = UserDefaults.standard.string(forKey: UserDefaultsKey.Uid.rawValue)!
	
	override init() {
		super.init()
		
		let socketBaseURL = URL(string: URL.baseURL)!
		manager = SocketManager(socketURL: socketBaseURL, config: [
			.log(true),
			.compress
		])
		
		socket = manager.defaultSocket
		
		socket.on(clientEvent: .connect) { data, ack in
			print("Socket Is CONNECTED", data, ack)
			print(self.uid)
			self.socket.emit("changesocketid", self.uid)
		}
		
		socket.on(clientEvent: .disconnect) { data, ack in
			print("Socket Is DiSCONNECTED", data, ack)
		}
		
		socket.on("chat") { dataArray, ack in
			print("SESAC RECEIVED", dataArray)
			let data = dataArray[0] as! NSDictionary
			let chat = data["chat"] as! String
			let createdAt = data["createdAt"] as! String
			let from = data["from"] as! String
			let to = data["to"] as! String
			
			
			print("Check", chat, createdAt)
			
			NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat": chat, "createdAt": createdAt, "from": from, "to": to])
		}
		
	}
	
	func establishConnection() {
		socket.connect()
	}
	
	func closeConnection() {
		socket.disconnect()
	}
	
}

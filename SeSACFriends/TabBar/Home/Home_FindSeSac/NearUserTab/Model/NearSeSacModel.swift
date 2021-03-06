//
//  FindNearSeSacModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/18.
//

import Foundation

struct sesacUsers {
	
	var fromUser: [sesacUser] = []
	var recommendUser: [sesacUser] = []
	
	mutating func setUpFromQueueDB(userList: OnQueueModel) {
		fromUser.removeAll()
		recommendUser.removeAll()
		userList.fromQueueDBRequested.forEach {
			recommendUser.append(sesacUser(queueDB: $0))
		}
	}
	
	
}

struct sesacUser {
	let nick, uid: String
	let reputation: [Int]
	let reviews: [String]
	let sesac, background: Int
	var isOpen: Bool
	init(queueDB: User) {
		self.nick = queueDB.nick
		self.uid = queueDB.uid
		self.reputation = queueDB.reputation
		self.reviews = queueDB.reviews
		self.sesac = queueDB.sesac
		self.background = queueDB.background
		self.isOpen = true
	}
	
}

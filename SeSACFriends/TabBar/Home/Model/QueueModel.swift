//
//  QueueModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/10.
//

import Foundation

struct OnQueueModel: Codable {
	let fromQueueDB: [User]
	let fromQueueDBRequested: [User]
	let fromRecommend: [String]
}

// MARK: - FromQueueDB
struct User: Codable {
	let uid, nick: String
	let lat, long: Double
	let reputation: [Int]
	let hf, reviews: [String]
	let gender, type, sesac, background: Int
}


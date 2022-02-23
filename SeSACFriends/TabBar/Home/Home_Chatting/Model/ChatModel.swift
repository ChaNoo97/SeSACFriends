//
//  ChatModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/23.
//

import Foundation

// MARK: - Chat
struct Chat: Codable {
	let id: String
	let v: Int
	let to, from, chat, createdAt: String

	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case v = "__v"
		case to, from, chat, createdAt
	}
}


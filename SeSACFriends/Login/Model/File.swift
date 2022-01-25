//
//  File.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/25.
//

import Foundation

public struct signUpModel: Encodable {
	let phoneNum, FCMtoken, nick, email: String
	let gender: Int
	let birth: Date
}

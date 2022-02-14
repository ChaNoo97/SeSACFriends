//
//  StateCodeEnum.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/04.
//

import Foundation


enum StateCodeEnum: Int {
	case success = 200
	case existUser = 201
	case impossibleNick = 202
	case fireBaseTokenError = 401
	case unenteredUser = 406
	case serverError = 500
	case clientError = 501
}

enum QueueStateCodeEnum: Int {
	case success = 200
	case ban = 201
	case stReport = 203
	case ndReport = 204
	case rdReport = 205
	case undecidedGender = 206
	case fireBaseTokenError = 401
	case unenteredUser = 406
	case serverError = 500
	case clientError = 501
}


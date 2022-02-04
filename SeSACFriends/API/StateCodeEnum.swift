//
//  StateCodeEnum.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/04.
//

import Foundation


enum UserStateCodeEnum: Int {
	case success = 200
	case existUser = 201
	case impossibleNick = 202
	case fireBaseTokenError = 401
	case unenteredUser = 406
	case servewError = 500
	case clientError = 501
}



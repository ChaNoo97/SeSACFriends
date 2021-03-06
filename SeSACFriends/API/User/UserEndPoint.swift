//
//  EndPoint.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/25.
//

import Foundation
import Alamofire

enum UserEndPoint {
	case user
	case withdraw
	case mypage
	case updateFCMtoken
}

extension UserEndPoint {
	var url: URL {
		switch self {
		case .user:
			return .makeEndPoint("/user")
		case .withdraw:
			return .makeEndPoint("/user/withdraw")
		case .mypage:
			return .makeEndPoint("/user/update/mypage")
		case .updateFCMtoken:
			return .makeEndPoint("/user/update_fcm_token")
		}
	}
}

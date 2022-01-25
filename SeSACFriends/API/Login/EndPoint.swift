//
//  EndPoint.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/25.
//

import Foundation
import Alamofire

struct LoginRequest {
	static let loginHeaders = ["idtoken": UserDefaults.standard.string(forKey: UserDefaultsKey.idToken.rawValue)!, "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
}

enum UserEndPoint {
	case singUp
	case signIn
	case withdraw
}

extension UserEndPoint {
	var url: URL {
		switch self {
		case .singUp:
			return .makeEndPoint("/user")
		case .signIn:
			return .makeEndPoint("/user")
		case .withdraw:
			return .makeEndPoint("/user/withdraw")
		}
	}
}

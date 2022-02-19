//
//  BaseHeader.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/19.
//

import Foundation
import Alamofire

enum BaseHeader {
	case loginHeaders
	case normalHeaders
}

extension BaseHeader {
	var headers: HTTPHeaders {
		switch self {
		case .loginHeaders:
			return ["idtoken": UserDefaults.standard.string(forKey: UserDefaultsKey.idToken.rawValue)!, "Content-Type": "application/x-www-form-urlencoded"]
			
		case .normalHeaders:
			return ["idtoken": UserDefaults.standard.string(forKey: UserDefaultsKey.idToken.rawValue)!]
		}
	}
}

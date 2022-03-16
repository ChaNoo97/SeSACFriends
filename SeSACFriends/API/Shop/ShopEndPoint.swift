//
//  ShopEndPoint.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/03/15.
//

import Foundation

enum ShopEndPoint {
	case shopMyinfo
	case updateMyImage
}

extension ShopEndPoint {
	var url: URL {
		switch self {
		case .shopMyinfo:
			return .makeEndPoint("/user/shop/myinfo")
		case .updateMyImage:
			return .makeEndPoint("/user/update/shop")
		}
	}
}

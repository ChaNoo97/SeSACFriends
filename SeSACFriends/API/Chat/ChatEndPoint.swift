//
//  EndPoint.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/23.
//

import Foundation

enum ChatEndPoint {
	case chat(id: String)
}

extension ChatEndPoint {
	var url: URL {
		switch self {
		case .chat(id: let id):
			return .makeEndPoint("/chat/"+id)
		}
	}
}

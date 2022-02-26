//
//  EndPoint.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/23.
//

import Foundation

enum ChatEndPoint {
	case chat(id: String)
	case lastChat(fromId: String, lastChatDate: String)
	case dodge
}

extension ChatEndPoint {
	var url: URL {
		switch self {
		case .chat(id: let id):
			return .makeEndPoint("/chat/"+id)
		case .lastChat(fromId: let fromId, lastChatDate: let lastChatDate):
			return .makeEndPoint("/chat/\(fromId)?lastchatDate=\(lastChatDate)")
		case .dodge:
			return .makeEndPoint("/queue/dodge")
		}
	}
}

//
//  Endpoint.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/09.
//

import Foundation


enum QueueEndPoint {
	case searching
	case onQueue
}

extension QueueEndPoint {
	var url: URL {
		switch self {
		case .searching:
			return .makeEndPoint("/queue")
		case .onQueue:
			return .makeEndPoint("/queue/onqueue")
		}
	}
}


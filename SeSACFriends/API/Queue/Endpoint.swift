//
//  Endpoint.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/09.
//

import Foundation


enum QueueEndPoint {
	case queue
	case onQueue
}

extension QueueEndPoint {
	var url: URL {
		switch self {
		case .queue:
			return .makeEndPoint("/queue")
		case .onQueue:
			return .makeEndPoint("/queue/onqueue")
		}
	}
}


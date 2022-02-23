//
//  Endpoint.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/09.
//

import Foundation
import Alamofire


enum QueueEndPoint {
	case queue
	case onQueue
	case queueStatus
	case hobbyRequest
	case hobbyAccept
}

extension QueueEndPoint {
	var url: URL {
		switch self {
		case .queue:
			return .makeEndPoint("/queue")
		case .onQueue:
			return .makeEndPoint("/queue/onqueue")
		case .queueStatus:
			return .makeEndPoint("/queue/myQueueState")
		case .hobbyRequest:
			return .makeEndPoint("/queue/hobbyrequest")
		case .hobbyAccept:
			return .makeEndPoint("/queue/hobbyaccept")
		}
	}
}

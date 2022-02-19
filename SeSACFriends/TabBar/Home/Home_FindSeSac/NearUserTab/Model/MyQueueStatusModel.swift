//
//  MyQueueStatus.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/19.
//

import Foundation

// MARK: - QueueStatus
struct QueueStatusModel: Codable {
	let dodged, matched, reviewed: Int
	let matchedNick, matchedUid: String?
}

//
//  QueueParameterModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/14.
//

import Foundation

struct QueueParameterModel: Encodable {
	let region, type: Int
	let lat, long: Double
	let hf: [String]
}

//
//  HomeViewModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/07.
//

import Foundation

final class HomeViewModel {
	let queueDB = Observable(OnQueueModel(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
	let region = Observable(0)
	let lat: Observable<Double> = Observable(0)
	let long: Observable<Double> = Observable(0)
	var userLocation = Observable([[0.0, 0.0]])
	
	
	func operationRegion(lat: Double, long: Double) -> Int {
		let front = floor((lat+90)*100)
		let back = floor((long+180)*100)
		let out = Int((front*100000) + back)
		return out
	}	
	
	func onQueue(completion: @escaping(String?) -> Void) {
		
		let model = onQueueParameterModel(region: region.value, lat: lat.value, long: long.value)
		
		QueueApiService.onQueue(model: model) { data, code in
			guard let data = data else {
				return
			}
			switch StateCodeEnum(rawValue: code)! {
			case .success:
				self.queueDB.value = data
				self.setupUserRegion(data: data)
				print(data.fromQueueDB)
				completion("nil")
			case .fireBaseTokenError:
				completion("token error")
			case .unenteredUser:
				completion("미가입유져")
			case .servewError:
				completion("오류")
			case .clientError:
				completion("오류")
			default:
				break
			}
		}
	}
	
	func setupUserRegion(data: OnQueueModel) {
		let count = data.fromQueueDB.count
		if count != 0 {
			userLocation.value.removeAll()
			for i in 0...count-1 {
				let lat = data.fromQueueDB[i].lat
				let long = data.fromQueueDB[i].long
				userLocation.value.append([lat, long])
			}
		}
	}
}

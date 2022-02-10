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
	var annotationArray = Observable([User.self])
	var manUser = [User(uid: "", nick: "", lat: 0, long: 0, reputation: [], hf: [], reviews: [], gender: 0, type: 0, sesac: 0, background: 0)]
	var womanUSer = [User(uid: "", nick: "", lat: 0, long: 0, reputation: [], hf: [], reviews: [], gender: 0, type: 0, sesac: 0, background: 0)]
	var allUser = [User(uid: "", nick: "", lat: 0, long: 0, reputation: [], hf: [], reviews: [], gender: 0, type: 0, sesac: 0, background: 0)]
	var selectGender = Observable(0)
	
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
			self.userLocation.value.removeAll()
			switch StateCodeEnum(rawValue: code)! {
			case .success:
				self.validGender(data: data)
				self.queueDB.value = data
//				self.setupUserRegion(data: data)
				print("onQueue api?",data.fromQueueDB)
				completion(nil)
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
	
	
	func validGender(data: OnQueueModel) {
		removeArray()
		data.fromQueueDB.forEach {
			allUser.append($0)
			if $0.gender == 0 {
				womanUSer.append($0)
			} else {
				manUser.append($0)
			}
		}
	}
	
	func removeArray() {
		allUser.removeAll()
		manUser.removeAll()
		womanUSer.removeAll()
	}

	func setUpSesacStyle(_ sesac: Int) -> sesacImageStyle {
		switch sesac {
		case 0:
			return .face1
		case 1:
			return .face2
		case 2:
			return .face3
		case 3:
			return .face4
		case 4:
			return .face5
		default:
			return .face1
		}
	}
}

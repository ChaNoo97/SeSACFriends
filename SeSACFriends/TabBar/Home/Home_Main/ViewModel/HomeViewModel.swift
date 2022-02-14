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
	var test: [User] = []
	var manUser: [User] = []
	var womanUSer: [User] = []
	var allUser: [User] = []
	var selectGender = Observable(0)
	var recommendArray: [String] = []
	var hfArray: [String] = []
	
	func operationRegion(lat: Double, long: Double) -> Int {
		let front = floor((lat+90)*100)
		let back = floor((long+180)*100)
		let out = Int((front*100000) + back)
		return out
	}	
	
	func onQueue(completion: @escaping(String?) -> Void) {
		
		let model = OnQueueParameterModel(region: region.value, lat: lat.value, long: long.value)
		 
		QueueApiService.onQueue(model: model) { data, code in
			guard let data = data else {
				return
			}
			switch StateCodeEnum(rawValue: code)! {
			case .success:
				self.validGender(data: data)
				self.setUpHfArray(data: data)
				self.queueDB.value = data
				self.recommendArray = data.fromRecommend
				print("onQueue api?",data)
				completion(nil)
			case .fireBaseTokenError:
				completion("token error")
			case .unenteredUser:
				completion("미가입유져")
			case .serverError:
				completion("오류")
			case .clientError:
				completion("오류")
			default:
				break
			}
		}
	}
	
	func setUpHfArray(data: OnQueueModel) {
		hfArray.removeAll()
		data.fromQueueDB.forEach {
			$0.hf.forEach {
				if !hfArray.contains($0) {
					hfArray.append($0)
				}
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

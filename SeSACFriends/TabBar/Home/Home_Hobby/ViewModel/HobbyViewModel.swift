//
//  HobbyViewModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/13.
//

import Foundation
import UIKit

final class HobbyViewModel {
	var recommendArray: [String] = []
	var hfArray: Observable<[String]> = Observable([])
	var subHfArray: [String] = []
	var myHobbyArray: Observable<[String]> = Observable([])
	var region: Int = 0
	var long: Double = 0
	var lat: Double = 0
	
	func onQueue(completion: @escaping () -> Void) {
		let model = OnQueueParameterModel(region: region, lat: lat, long: long)
		QueueApiService.onQueue(model: model) { data, code in
			guard let data = data else {
				return
			}
			switch StateCodeEnum(rawValue: code)! {
			case .success:
				self.recommendArray = data.fromRecommend
				self.setUpSubHfarray(data: data)
				self.selectHfArray(array: self.subHfArray)
				completion()
			case .fireBaseTokenError:
				QueueApiService.onQueue(model: model) { data, code in
					guard let data = data else {
						return
					}
					switch StateCodeEnum(rawValue: code)! {
					case .success:
						self.recommendArray = data.fromRecommend
						self.setUpSubHfarray(data: data)
						self.selectHfArray(array: self.subHfArray)
						completion()
					default:
						return
					}
				}
			default:
				return
			}
		}
	}
	
	func queue(completion: @escaping (String?, UIViewController?) -> Void) {
		var modelHF: [String] = []
		if myHobbyArray.value.count == 0 {
			modelHF = ["anything"]
		} else {
			modelHF = myHobbyArray.value
		}
		let model = QueueParameterModel(region: region, type: 2, lat: lat, long: long, hf: modelHF)
		QueueApiService.postQueue(model: model) { code in
			guard let code = code else {
				return
			}
			print(code)
			switch QueueStateCodeEnum(rawValue: code)! {
			case .success:
				completion(nil, FindSeSacTabViewController())
			case .ban:
				completion("신고가 누적되어 이용하실 수 없습니다.", nil)
			case .stReport:
				completion("약속 취소 패널티로, 1분동안 이용하실 수 없습니다", nil)
			case .ndReport:
				completion("약속 취소 패널티로, 2분동안 이용하실 수 없습니다", nil)
			case .rdReport:
				completion("약속 취소 패널티로, 3분동안 이용하실 수 없습니다", nil)
			case .undecidedGender:
				completion("새싹 찾기 기능을 이용하기 위해서는 성별이 필요해요!", MyInfoManageViewController())
			case .fireBaseTokenError:
				FIRAuth.renewIdToken {
					QueueApiService.postQueue(model: model) { code in
						guard let code = code else {
							return
						}
						switch QueueStateCodeEnum(rawValue: code)! {
						case .success:
							completion(nil, FindSeSacTabViewController())
						case .ban:
							completion("신고가 누적되어 이용하실 수 없습니다.", nil)
						case .stReport:
							completion("약속 취소 패널티로, 1분동안 이용하실 수 없습니다", nil)
						case .ndReport:
							completion("약속 취소 패널티로, 2분동안 이용하실 수 없습니다", nil)
						case .rdReport:
							completion("약속 취소 패널티로, 3분동안 이용하실 수 없습니다", nil)
						case .undecidedGender:
							completion("새싹 찾기 기능을 이용하기 위해서는 성별이 필요해요!", MyInfoManageViewController())
						case .fireBaseTokenError:
							completion("앱 내부 오류. 잠시후 다시 시도해주세요.", nil)
						case .unenteredUser:
							completion("알수없는 오류. 앱을 다시 실행해 주세요.", nil)
						case .serverError:
							completion("서버오류. 잠시후 다시 시도해 주세요.", nil)
						default:
							break
						}
					}
				}
			case .unenteredUser:
				completion("알수없는 오류. 앱을 다시 실행해 주세요.", nil)
			case .serverError:
				completion("서버오류. 잠시후 다시 시도해 주세요.", nil)
			default:
				break
			}
		}
	}
	
	func checkOverlap(value: String, completion: (String?) -> Void) {
		if myHobbyArray.value.count < 8 {
			if myHobbyArray.value.contains(value) {
				completion("이미 추가된 취미입니다.")
			} else {
				completion(nil)
			}
		} else {
			completion("취미를 더 이상 추가할 수 없습니다")
		}
	}
	
	func valid(pattern: String, input: Any?) -> Bool {
		let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
		return pred.evaluate(with: input)
	}
	
	func setUpSubHfarray(data: OnQueueModel) {
		subHfArray.removeAll()
		data.fromQueueDB.forEach {
			$0.hf.forEach {
				if !subHfArray.contains($0) {
					subHfArray.append($0)
				}
			}
		}
	}
	
	func selectHfArray(array: [String]) {
		if array.count == hfArray.value.count {
			return
		} else {
			hfArray.value = array
		}
	}

}


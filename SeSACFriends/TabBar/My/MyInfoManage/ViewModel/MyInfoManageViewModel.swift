//
//  MyInfoManageViewModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/04.
//

import Foundation

class MyInfoManageViewModel {
	
	let userInfo = Observable(UserInfo(id: "", v: 0, uid: "", phoneNumber: "", email: "", fcMtoken: "", nick: "", birth: "", gender: 0, hobby: "", comment: [""], reputation: [0], sesac: 0, sesacCollection: [0], background: 0, backgroundCollection: [0], purchaseToken: [""], transactionID: [""], reviewedBefore: [""], reportedNum: 0, reportedUser: [""], dodgepenalty: 0, dodgeNum: 0, ageMin: 0, ageMax: 0, searchable: 0, createdAt: ""))
	
//	var user: Observable<UserInfo?> = Observable(nil)
	let gender = Observable(0)
	let permissionMynum = Observable(0)
	let age = Observable([0, 0])
	let hobby = Observable("")
	
	
	
	func callUserInfo(completion: @escaping ()-> Void) {
		UserApiService.logIn { data, code, error in
			switch code {
			case 200:
				guard let data = data else {
					return
				}
				print(data)
				self.userInfo.value = data
				self.bindData()
				completion()
			case 401:
				FIRAuth.renewIdToken {
					UserApiService.logIn { data, code, error in
						guard let data = data else {
							return
						}
						self.userInfo.value = data
						self.bindData()
						completion()
					}
				}
			default:
				return
			}
		}
	}
	
	func checkReview(completion: @escaping (String, Int) -> Void) {
		let commentArray = userInfo.value.comment
		if commentArray.count == 0 {
			completion("", 0)
		} else {
			completion(commentArray[0], commentArray.count)
		}
	}
	
	func bindData() {
		gender.value = userInfo.value.gender
		permissionMynum.value = userInfo.value.searchable
		age.value = [userInfo.value.ageMin, userInfo.value.ageMax]
		hobby.value = userInfo.value.hobby
	}
	
	func checkChange() -> Bool {
		if gender.value == userInfo.value.gender && permissionMynum.value == userInfo.value.searchable && age.value == [userInfo.value.ageMin, userInfo.value.ageMax] && hobby.value == userInfo.value.hobby {
			return false
		} else {
			return true
		}
	}
	
	func updateMypage(completion: @escaping(String) -> Void) {
		
		let updateMypageModel = UpdateMypageModel(
			searchable: permissionMynum.value,
			ageMin: age.value[0],
			ageMax: age.value[1],
			gender: gender.value,
			hobby: hobby.value)
		
		UserApiService.updateMypage(model: updateMypageModel) { statusCode, error in
			if let error = error {
				return
			}
			guard let statusCode = statusCode else {
				return
			}
			
			switch StateCodeEnum(rawValue: statusCode)! {
			case .success:
				completion("업데이트 성공")
			case .fireBaseTokenError:
				FIRAuth.renewIdToken {
					UserApiService.updateMypage(model: updateMypageModel) { statusCode, error in
						if let error = error {
							return
						}
						guard let statusCode = statusCode else {
							return
						}
						switch StateCodeEnum(rawValue: statusCode)! {
						case .success:
							completion("업데이트 성공")
						case .fireBaseTokenError:
							completion("유저 인증 오류")
						case .serverError:
							completion("서버 오류")
						case .clientError:
							completion("클라이언트 오류")
						default :
							break
						}
					}
				}
			case .serverError:
				completion("서버 오류")
			case .clientError:
				completion("클라이언트 오류")
			default :
				break
			}
		}
	}
	
}

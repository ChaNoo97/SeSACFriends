//
//  NearUserViewModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/15.
//

import Foundation
import UIKit

enum CallStatus {
	case timer
	case requestButton
	case acceptButton
	case chatting
}

extension CallStatus {
	var message: String {
		switch self {
		case .timer:
			return "님과 매칭되셨습니다. 잠시 후 채팅방으로 이동합니다"
		case .requestButton:
			return "상대방도 취미 함께 하기 요청을 했습니다. 채팅방으로 이동합니다"
		case .acceptButton:
			return "채팅방으로 이동합니다"
		case .chatting:
			return "취미 함께하기가 종료되어 채팅을 전송할 수 없습니다"
		}
	}
}

final class NearUserViewModel {
	
	static let shared = NearUserViewModel()
	
	var region: Int = 0
	var lat: Double = 0
	var long: Double = 0

	var nearSesac: sesacUsers = sesacUsers()
	
	func setUpReputationView(view: ReputationView, reputationArray: [UILabel], reputationNum: [Int]) {
		for i in 0...reputationArray.count-1 {
			view.setUpReputationLabel(
				num: reputationNum[i],
				reputationLabel: reputationArray[i]
			)
		}
	}
	
	func deleteQueue(completion: @escaping (String?, UIViewController?) -> Void) {
		QueueApiService.deleteQueue { code in
			guard let code = code else {
				return
			}
			switch StateCodeEnum(rawValue: code)! {
			case .success:
				UserDefaults.standard.set(queueState.normal.rawValue, forKey: UserDefaultsKey.queueStatus.rawValue)
				completion(nil, TabBarController())
			case .existUser:
				completion("누군가와 취미를 함께하기로 약속하셨어요!", ChattingViewController())
			case .fireBaseTokenError:
				FIRAuth.renewIdToken {
					QueueApiService.deleteQueue { code in
						guard let code = code else {
							return
						}
						switch StateCodeEnum(rawValue: code)! {
						case .success:
							UserDefaults.standard.set(queueState.normal.rawValue, forKey: UserDefaultsKey.queueStatus.rawValue)
							completion(nil, HomeViewController())
						case .existUser:
							completion("누군가와 취미를 함께하기로 약속하셨어요!", nil/*(채팅뷰컨)*/)
						default:
							return
						}
					}
				}
			default:
				return
			}
		}
	}
	
	func onQueue(completion: @escaping () -> Void) {

		let model = OnQueueParameterModel(region: self.region, lat: self.lat, long: self.long)

		QueueApiService.onQueue(model: model) { data, code in
			guard let code = code else {
				return
			}
			switch StateCodeEnum(rawValue: code)! {
			case .success:
				if let data = data {
					self.nearSesac.setUpFromQueueDB(userList: data)
					data.fromQueueDB.forEach {
						switch UserDefaults.standard.integer(forKey: UserDefaultsKey.genderStstus.rawValue) {
						case 0 :
							if $0.gender == 0 {
								self.nearSesac.fromUser.append(sesacUser(queueDB: $0))
							}
						case 1:
							if $0.gender == 1 {
								self.nearSesac.fromUser.append(sesacUser(queueDB: $0))
							}
						case 2:
							self.nearSesac.fromUser.append(sesacUser(queueDB: $0))
						default:
							self.nearSesac.setUpFromQueueDB(userList: data)
						}
					}
					completion()
				}
			case .fireBaseTokenError:
				FIRAuth.renewIdToken {
					QueueApiService.onQueue(model: model) { data, code in
						guard let code = code else {
							return
						}
						switch StateCodeEnum(rawValue: code)! {
						case .success:
							if let data = data {
								self.nearSesac.setUpFromQueueDB(userList: data)
								data.fromQueueDB.forEach {
									switch UserDefaults.standard.integer(forKey: UserDefaultsKey.genderStstus.rawValue) {
									case 0 :
										if $0.gender == 0 {
											self.nearSesac.fromUser.append(sesacUser(queueDB: $0))
										}
									case 1:
										if $0.gender == 1 {
											self.nearSesac.fromUser.append(sesacUser(queueDB: $0))
										}
									case 2:
										self.nearSesac.fromUser.append(sesacUser(queueDB: $0))
									default:
										self.nearSesac.setUpFromQueueDB(userList: data)
									}
								}
								completion()
							}
						default:
							return
						}
					}
				}
			default:
				return
			}
		}
	}
	
	func myStatus(callStatus: CallStatus, completion: @escaping (String?, UIViewController?) -> Void) {
		QueueApiService.myQueueStatus { data, code in
			guard let code = code else {
				return
			}

			switch StateCodeEnum(rawValue: code)! {
			case .success:
				if let data = data {
					if data.matched == 1 {
						switch callStatus {
						case .timer:
							if let nick = data.matchedNick {
								completion(nick+callStatus.message, ChattingViewController())
							}
						case .requestButton:
							completion(callStatus.message, nil)
						case .acceptButton:
							completion(callStatus.message, nil)
						default:
							return
						}
					}
				}
			case .existUser:
				completion("오랜 시간 동안 매칭 되지 않아 새싹 친구 찾기를 그만둡니다.", nil)
			case .fireBaseTokenError:
				FIRAuth.renewIdToken {
					QueueApiService.myQueueStatus { data, code in
						guard let code = code else {
							return
						}
						
						switch StateCodeEnum(rawValue: code)! {
						case .success:
							if let data = data {
								if data.matched == 1 {
									switch callStatus {
									case .timer:
										if let nick = data.matchedNick {
											completion(nick+callStatus.message, ChattingViewController())
										}
									case .requestButton:
										completion(callStatus.message, nil)
									case .acceptButton:
										completion(callStatus.message, nil)
									default:
										return
									}
								}
							}
						case .existUser:
							completion("오랜 시간 동안 매칭 되지 않아 새싹 친구 찾기를 그만둡니다.", nil)
						default:
							completion("알수없는 오류. 앱을 재실행 해주세요", nil)
						}

					}
				}
			default:
				completion("알수없는 오류.", nil)
			}
		}
	}
	
	func hobbyRequest(_ otheruid: String, completion: @escaping(String?, UIViewController?) -> Void) {
		QueueApiService.hobbyRequest(otheruid: otheruid) { code in
			if let code = code {
				switch hobbyEnum(rawValue: code)! {
				case .success:
					completion("취미 함께 하기 요청을 보냈습니다", nil)
				case .alreadyOtherMatched:
					completion("상대방이 이미 다른 사람과 취미를 함께하는 중입니다.", nil)
				case .otherSuspended:
					completion("상대방이 취미 함께 하기를 그만두었습니다.", nil)
				case .alreadyMatched:
					completion("앗! 누군가가 나의 취미 함께 하기를 수락하였어요! ", nil)
				case .firebaseTokenerror:
					FIRAuth.renewIdToken {
						QueueApiService.hobbyRequest(otheruid: otheruid) { code in
							if let code = code {
								switch hobbyEnum(rawValue: code)! {
								case .success:
									completion(nil, ChattingViewController())
								case .alreadyOtherMatched:
									completion("상대방이 이미 다른 사람과 취미를 함께하는 중입니다.", nil)
								case .otherSuspended:
									completion("상대방이 취미 함께 하기를 그만두었습니다.", nil)
								case .alreadyMatched:
									completion("앗! 누군가가 나의 취미 함께 하기를 수락하였어요! ", nil)
								default:
									return
								}
							}
						}
					}
				default:
					return
				}
			}
		}
	}
	
	func hobbyAccept(_ otheruid: String, completion: @escaping(String?, UIViewController?) -> Void) {
		QueueApiService.acceptRequest(otheruid: otheruid) { code in
			if let code = code {
				switch hobbyEnum(rawValue: code)! {
				case .success:
					UserDefaults.standard.set(queueState.matched.rawValue, forKey: UserDefaultsKey.queueStatus.rawValue)
					completion(nil, ChattingViewController())
				case .alreadyOtherMatched:
					completion("상대방이 이미 다른 사람과 취미를 함께하는 중입니다.", nil)
				case .otherSuspended:
					completion("상대방이 취미 함께 하기를 그만두었습니다.", nil)
				case .alreadyMatched:
					completion("앗! 누군가가 나의 취미 함께 하기를 수락하였어요! ", nil)
				case .firebaseTokenerror:
					FIRAuth.renewIdToken {
						QueueApiService.hobbyRequest(otheruid: otheruid) { code in
							if let code = code {
								switch hobbyEnum(rawValue: code)! {
								case .success:
									UserDefaults.standard.set(queueState.matched.rawValue, forKey: UserDefaultsKey.queueStatus.rawValue)
									completion(nil, ChattingViewController())
								case .alreadyOtherMatched:
									completion("상대방이 이미 다른 사람과 취미를 함께하는 중입니다.", nil)
								case .otherSuspended:
									completion("상대방이 취미 함께 하기를 그만두었습니다.", nil)
								case .alreadyMatched:
									completion("앗! 누군가가 나의 취미 함께 하기를 수락하였어요! ", nil)
								default:
									return
								}
							}
						}
					}
				default:
					return
				}
			}
		}
	}
}




//
//  ChattingViewModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/22.
//

import Foundation

final class ChattingViewModel {
	
	var textCount = Observable(0)
	var chatPossibility = Observable(false)
	var otherNick: Observable<String> = Observable("")
	var otherUid: Observable<String> = Observable("")
	let myUid = UserDefaults.standard.string(forKey: UserDefaultsKey.Uid.rawValue)!
	var chatList: [Chat] = []
	var validText: Observable<String> = Observable("")
	
	func sendButtonSetting(_ textCount: Int) -> String {
		if textCount != 0 && chatPossibility.value {
			return "active"
		} else {
			return "inactive"
		}
	}
	
	func checkMyState(completion: @escaping(String?) -> Void) {
		QueueApiService.myQueueStatus { data, code in
			if let code = code {
				guard let data = data else {
					return
				}
				switch QueueStateCodeEnum(rawValue: code)! {
				case .success:
					if data.matched == 1 {
						self.chatPossibility.value = true
						self.otherNick.value = data.matchedNick!
						self.otherUid.value = data.matchedUid!
					}
					if data.dodged == 1 || data.reviewed == 1 {
						self.chatPossibility.value = false
						if let uid = data.matchedUid {
							if let nick = data.matchedNick {
								self.otherNick.value = nick
								self.otherUid.value = uid
							}
						}
						completion("약속이 종료되어 채팅을 보낼 수 없습니다.")
					}
				case .fireBaseTokenError:
					FIRAuth.renewIdToken {
						QueueApiService.myQueueStatus { data, code in
							if let code = code {
								switch QueueStateCodeEnum(rawValue: code)! {
								case .success:
									guard let data = data else {
										return
									}
									if data.matched == 1 {
										self.chatPossibility.value = true
										self.otherNick.value = data.matchedNick!
										self.otherUid.value = data.matchedUid!
									}
									if data.dodged == 1 || data.reviewed == 1 {
										self.chatPossibility.value = false
										if let uid = data.matchedUid {
											if let nick = data.matchedNick {
												self.otherNick.value = nick
												self.otherUid.value = uid
											}
										}
										completion("약속이 종료되어 채팅을 보낼 수 없습니다.")
									}
								case .serverError:
									completion("서버 오류")
								default:
									return
								}
							}
						}
					}
				case .serverError:
					completion("서버 오류")
				default:
					return
				}
			}
		}
	}
	
	func chatPost(chatText: String, completion: @escaping() -> Void) {
		ChatApiService.chat(otherUid: self.otherUid.value, chatText: chatText) { code, data in
			if let data = data {
				let myChat = Chat(id: "", v: 0, to: "", from: self.myUid, chat: data.chat, createdAt: "\(Date.now)")
				self.chatList.append(myChat)
				completion()
			}
		}
	}
	
	func takeLastChat(_ otherUid: String, completion: @escaping () -> Void) {
		guard let chatDate = UserDefaults.standard.string(forKey: UserDefaultsKey.chatLastDate.rawValue) else { return print("chatDate return") }
//		guard let fromId = UserDefaults.standard.string(forKey: UserDefaultsKey.from.rawValue) else { return
//			print("fromId Return")
//		}
//		print("chatDate: \(chatDate), fromId: \(fromId)")
		ChatApiService.lastChat(fromId: otherUid, lastDate: chatDate) { data in
			if let data = data {
				data.payload.forEach {
					self.chatList.append($0)
					completion()
				}
				print("$$",data.payload)
			}
		}
	}
}

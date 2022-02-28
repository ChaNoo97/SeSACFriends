//
//  ChatApiService.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/23.
//

import Foundation
import Alamofire

final class ChatApiService {
	
	static func chat(otherUid: String, chatText: String, completion: @escaping (Int, ChatResponseModel?) -> Void) {

		let parameters: Parameters = [
			"chat": chatText
		]
		
		AF.request(ChatEndPoint.chat(id: otherUid).url, method: .post, parameters: parameters, headers: BaseHeader.normalHeaders.headers).responseDecodable(of: ChatResponseModel.self) { response in
			print("ChatChatChat")
			print("code", response.response?.statusCode)
			completion(response.response!.statusCode, response.value)
		}
	}
	
	static func lastChat(fromId: String, lastDate: String, completion: @escaping (LastChat?) -> Void) {
		AF.request(ChatEndPoint.lastChat(fromId: fromId, lastChatDate: lastDate).url, method: .get, headers: BaseHeader.normalHeaders.headers).responseDecodable(of: LastChat.self) { response in
			print("=-=-=-=-=%%",response.response?.statusCode)
			completion(response.value)
		}
	}
	
	static func dodge(_ otherUid: String, completion: @escaping (Int?) -> Void) {
		
		let parameters: Parameters = [
			"otheruid": otherUid
		]
		
		AF.request(ChatEndPoint.dodge.url, method: .post, parameters: parameters, headers: BaseHeader.normalHeaders.headers).responseString { response in
			completion(response.response?.statusCode)
		}
	}
	
	static func report(otherUid: String, reportRepustation: [Int], comment: String, completion: @escaping (Int?) -> Void) {
		
		let parameters: Parameters = [
			"otheruid" : otherUid,
			"reportedReputation" : reportRepustation,
			"comment" : comment
		]
		
		AF.request(ChatEndPoint.report.url, method: .post, parameters: parameters, headers: BaseHeader.normalHeaders.headers).responseString { response in
			completion(response.response?.statusCode)
		}
	}
	
	static func review(otherUid: String, reputation: [Int], comment: String, completion: @escaping (Int?) -> Void) {
	
		let parameters: Parameters = [
			"otheruid" : otherUid,
			  "reputation": reputation,
			  "comment" : comment
		]
		print(parameters)
		AF.request(ChatEndPoint.review(id: otherUid).url, method: .post, parameters: parameters, headers: BaseHeader.normalHeaders.headers).responseString { response in
			completion(response.response?.statusCode)
		}
		print(ChatEndPoint.review(id: otherUid).url)
	}
	
}

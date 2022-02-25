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
			completion(response.response!.statusCode, response.value)
		}
	}
	
	static func lastChat(fromId: String, lastDate: String, completion: @escaping (LastChat?) -> Void) {
		AF.request(ChatEndPoint.lastChat(fromId: fromId, lastChatDate: lastDate).url, method: .get, headers: BaseHeader.normalHeaders.headers).responseDecodable(of: LastChat.self) { response in
			print("=-=-=-=-=%%",response.response?.statusCode)
			completion(response.value)
		}
	}
}

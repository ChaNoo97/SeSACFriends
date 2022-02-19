//
//  QueueApiService.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/09.
//

import Foundation
import Alamofire

final class QueueApiService {
	
	static func onQueue(model: OnQueueParameterModel, completion: @escaping (OnQueueModel?,Int?) -> Void) {
		let onQueueParameter: Parameters = [
			"region": model.region,
			"lat": model.lat,
			"long": model.long
		]
		AF.request(QueueEndPoint.onQueue.url, method: .post, parameters: onQueueParameter, headers: BaseHeader.normalHeaders.headers).responseDecodable(of: OnQueueModel.self) { response in
			completion(response.value, response.response?.statusCode)
		}
	}
	
	static func postQueue(model: QueueParameterModel, completion: @escaping (Int?) -> Void) {
		let queueParameter: Parameters = [
			"type": model.type,
			"region": model.region,
			"long": model.long,
			"lat": model.lat,
			"hf": model.hf
		]
		//AF 에서 URLEncoding(arrayEncoding: .noBrackets) 안해주면 501 에러 날라옴
		AF.request(QueueEndPoint.queue.url, method: .post, parameters: queueParameter, encoding: URLEncoding(arrayEncoding: .noBrackets), headers: BaseHeader.normalHeaders.headers).responseString { response in
			completion(response.response?.statusCode)
		}
	}
	
	static func deleteQueue(completion: @escaping (Int?) -> Void) {
		AF.request(QueueEndPoint.queue.url, method: .delete, headers: BaseHeader.normalHeaders.headers).responseString { response in
			print("====delete=====",response.response?.statusCode)
			completion(response.response?.statusCode)
		}
	}
	
	static func myQueueStatus(completion: @escaping (QueueStatusModel?, Int?) -> Void) {
		AF.request(QueueEndPoint.queueStatus.url, method: .get, headers: BaseHeader.normalHeaders.headers).responseDecodable(of: QueueStatusModel.self) { response in
			print("myQueue Status Value", response.value)
			completion(response.value, response.response?.statusCode)
		}
	}

	static func hobbyRequest(otheruid: String, completion: @escaping (Int?) -> Void) {
		let hobbyRequestParameters: Parameters = [
			"otheruid": otheruid
		]
		AF.request(QueueEndPoint.hobbyRequest.url, method: .post, parameters: hobbyRequestParameters, headers: BaseHeader.normalHeaders.headers).responseString { response in
			completion(response.response?.statusCode)
		}
	}
	
	static func acceptRequest(otheruid: String, completion: @escaping (Int?) -> Void) {
		let hobbyRequestParameters: Parameters = [
			"otheruid": otheruid
		]
		AF.request(QueueEndPoint.hobbyAccept.url, method: .post, parameters: hobbyRequestParameters, headers: BaseHeader.normalHeaders.headers).responseString { response in
			completion(response.response?.statusCode)
		}
	}
	
}

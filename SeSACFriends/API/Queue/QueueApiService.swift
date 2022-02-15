//
//  QueueApiService.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/09.
//

import Foundation
import Alamofire

final class QueueApiService {
	
	static func onQueue(model: OnQueueParameterModel, completion: @escaping (OnQueueModel?,Int) -> Void) {
		let onQueueParameter: Parameters = [
			"region": model.region,
			"lat": model.lat,
			"long": model.long
		]
		AF.request(QueueEndPoint.onQueue.url, method: .post, parameters: onQueueParameter, headers: QueueHeader.header).responseDecodable(of: OnQueueModel.self) { response in
			completion(response.value, response.response!.statusCode)
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
		AF.request(QueueEndPoint.queue.url, method: .post, parameters: queueParameter, encoding: URLEncoding(arrayEncoding: .noBrackets), headers: QueueHeader.header).responseString { response in
			completion(response.response?.statusCode)
		}
	}
	
	static func deleteQueue(completion: @escaping (Int?) -> Void) {
		AF.request(QueueEndPoint.queue.url, method: .delete, headers: QueueHeader.header).responseString { response in
			print("====delete=====",response.response?.statusCode)
			completion(response.response?.statusCode)
		}
	}
}

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
		guard let idtoken = UserDefaults.standard.string(forKey: UserDefaultsKey.idToken.rawValue) else { return }
		let header = ["idtoken": idtoken] as HTTPHeaders
		let onQueueParameter: Parameters = [
			"region": model.region,
			"lat": model.lat,
			"long": model.long
		]
		AF.request(QueueEndPoint.onQueue.url, method: .post, parameters: onQueueParameter, headers: header).responseDecodable(of: OnQueueModel.self) { response in
			completion(response.value, response.response!.statusCode)
		}
	}
	
	static func postQueue(model: QueueParameterModel, completion: @escaping (Int?) -> Void) {
		guard let idtoken = UserDefaults.standard.string(forKey: UserDefaultsKey.idToken.rawValue) else { return }
		let header = ["idtoken": idtoken] as HTTPHeaders
		let queueParameter: Parameters = [
			"type": model.type,
			"region": model.region,
			"long": model.long,
			"lat": model.lat,
			"hf": model.hf
		]
		AF.request(QueueEndPoint.queue.url, method: .post, parameters: queueParameter, encoding: URLEncoding(arrayEncoding: .noBrackets), headers: header).responseString { response in
			completion(response.response?.statusCode)
		}
	}
}

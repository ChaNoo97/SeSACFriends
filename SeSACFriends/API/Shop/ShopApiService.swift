//
//  ShopApiService.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/03/15.
//

import Foundation
import Alamofire

final class ShopApiService {
	
	static func shopMyinfo(completion: @escaping (ShopModel?) -> Void) {
		AF.request(ShopEndPoint.shopMyinfo.url, method: .get, headers: BaseHeader.normalHeaders.headers).responseDecodable(of: ShopModel.self) { response in
			print(response.response?.statusCode)
			completion(response.value)
		}
	}
}

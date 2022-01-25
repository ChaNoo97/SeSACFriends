//
//  APIService.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/25.
//

import Foundation
import Alamofire

public class LoginApiService {
	static func signUp(model: signUpModel, completion: @escaping (Int?, Error?) -> Void) {
		
		let signUpParameter: Parameters = [
			"phoneNumber": model.phoneNum,
			"FCMtoken": model.FCMtoken,
			"nick": model.nick,
			"birth": model.birth,
			"email": model.email,
			"gender": model.gender
		]
		
		AF.request(
			UserEndPoint.singUp.url,
			method: .post,
			parameters: signUpParameter,
			headers: LoginRequest.loginHeaders).responseString { response in
				completion(response.response?.statusCode, nil)
		}
	}
	
	static func withdraw(completion: @escaping (Int?, Error?) -> Void) {
		guard let idtoken = UserDefaults.standard.string(forKey: UserDefaultsKey.idToken.rawValue) else { return }
		let param = ["idtoken": idtoken] as HTTPHeaders
		AF.request(UserEndPoint.withdraw.url,
				   method: .post,
				  headers: param).responseString { response in
			completion(response.response?.statusCode, nil)
		}
		
	}
}

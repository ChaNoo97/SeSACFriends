//
//  UserApiService.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/25.
//

import Foundation
import Alamofire

class UserApiService {
	
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
			UserEndPoint.user.url,
			method: .post,
			parameters: signUpParameter,
			headers: LoginRequest.loginHeaders).responseString { response in
				completion(response.response?.statusCode, nil)
		}
	}
	
	static func logIn(completion: @escaping (UserInfo?, Int?, Error?) -> Void ) {
		guard let idtoken = UserDefaults.standard.string(forKey: UserDefaultsKey.idToken.rawValue) else { return }
		let header = ["idtoken": idtoken] as HTTPHeaders
		AF.request(UserEndPoint.user.url, method: .get, headers: header).responseDecodable(of: UserInfo.self) { response in
			let code = response.response?.statusCode
			switch response.result {
			case.success(let data):
				UserDefaults.standard.set(data.nick, forKey: UserDefaultsKey.nickName.rawValue)
				completion(data,code,nil)
			case .failure(let error):
				completion(nil,code,error)
			}
		}
		
	}
	
	static func withdraw(completion: @escaping (Int?, Error?) -> Void) {
		guard let idtoken = UserDefaults.standard.string(forKey: UserDefaultsKey.idToken.rawValue) else { return }
		let header = ["idtoken": idtoken] as HTTPHeaders
		AF.request(UserEndPoint.withdraw.url,
				   method: .post,
				  headers: header).responseString { response in
			completion(response.response?.statusCode, nil)
		}
	}
	
	static func updateMypage(model: UpdateMypageModel, completion: @escaping (Int?, Error?) -> Void) {
		guard let idtoken = UserDefaults.standard.string(forKey: UserDefaultsKey.idToken.rawValue) else { return }
		let header = ["idtoken": idtoken] as HTTPHeaders
		let updateParameter: Parameters = [
			"searchable": model.searchable,
			"ageMin": model.ageMin,
			"ageMax": model.ageMax,
			"gender": model.gender,
			"hobby": model.hobby
		]
		
		AF.request(UserEndPoint.mypage.url,
				   method: .post,
				   parameters: updateParameter,
				   headers: header).responseString { response in
			completion(response.response?.statusCode, response.error)
		}
	}
	
	
	
}

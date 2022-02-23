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
			headers: BaseHeader.loginHeaders.headers).responseString { response in
				completion(response.response?.statusCode, nil)
		}
	}
	
	static func logIn(completion: @escaping (UserInfo?, Int?, Error?) -> Void ) {
		AF.request(UserEndPoint.user.url, method: .get, headers: BaseHeader.normalHeaders.headers).responseDecodable(of: UserInfo.self) { response in
			let code = response.response?.statusCode
			switch response.result {
			case.success(let data):
				//에러 존재..
				UserDefaults.standard.set(data.nick, forKey: UserDefaultsKey.nickName.rawValue)
				UserDefaults.standard.set(data.uid, forKey: UserDefaultsKey.Uid.rawValue)
				print("serverFCMTOKEN:",data.fcMtoken)
				print("MYUID!!!!!!!:", data.uid)
				print("신고", data.reportedNum)
				completion(data,code,nil)
			case .failure(let error):
				completion(nil,code,error)
			}
		}
		
	}
	
	static func withdraw(completion: @escaping (Int?, Error?) -> Void) {
		AF.request(UserEndPoint.withdraw.url,
				   method: .post,
				   headers: BaseHeader.normalHeaders.headers).responseString { response in
			completion(response.response?.statusCode, nil)
		}
	}
	
	static func updateMypage(model: UpdateMypageModel, completion: @escaping (Int?, Error?) -> Void) {
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
				   headers: BaseHeader.normalHeaders.headers).responseString { response in
			completion(response.response?.statusCode, response.error)
		}
	}
	
	static func updateFCMToken() {
		guard let fcmtoken = UserDefaults.standard.string(forKey:  UserDefaultsKey.FCMtoken.rawValue) else { return }
		let parameter: Parameters = [
			"FCMtoken": fcmtoken
		]
		AF.request(UserEndPoint.updateFCMtoken.url, method: .put, parameters: parameter, headers: BaseHeader.normalHeaders.headers).responseString { response in
			print(response.response?.statusCode)
		}
	}
	
}

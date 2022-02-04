//
//  LoginViewModel + extension(apiCall).swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/25.
//

import Foundation
import Alamofire

extension LoginViewModel {
	
	func signUP(completion: @escaping (Int?, Error?) -> Void) {
		let birth = stringToDate(input: birth.value)
		let phoneNum = UserDefaults.standard.string(forKey: UserDefaultsKey.userPhoneNum.rawValue)!
		let fcmtoken = UserDefaults.standard.string(forKey: UserDefaultsKey.FCMtoken.rawValue) ?? ""
		let signUpModel = signUpModel(
			phoneNum: phoneNum,
			FCMtoken: fcmtoken,
			nick: nickName.value,
			email: email.value,
			gender: gender.value,
			birth: birth)
		UserApiService.signUp(model: signUpModel) { statusCode, error in
			completion(statusCode, error)
		}
	}
	
}


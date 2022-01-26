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
		let signUpModel = signUpModel(
			phoneNum: cleanPhoneNum.value,
			FCMtoken: fcmtoken,
			nick: nickName.value,
			email: email.value,
			gender: gender.value,
			birth: birth)
		LoginApiService.signUp(model: signUpModel) { statusCode, error in
			completion(statusCode, error)
		}
	}
	
}


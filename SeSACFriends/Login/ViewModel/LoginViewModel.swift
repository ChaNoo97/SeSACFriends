//
//  LoginViewModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/22.
//

import Foundation
import FirebaseAuth

enum validPattern: String{
	case PhoneNumber = "(01[0-1])-([0-9]{3,4})-([0-9]{4})"
	case AuthNumber = "^([0-9]{6})$"
	case NickName = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9_]{1,10}$"
	case Email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
	case addHobby = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9_]{1,8}$"
}

final class LoginViewModel {
	
	static let shared = LoginViewModel()
	
	let cleanPhoneNum = Observable("")
	let authNum = Observable("")
	let nickName = Observable("")
	let birth = Observable("1990-01-01")
	let year = Observable("")
	let month = Observable("")
	let day = Observable("")
	let email = Observable("")
	let gender = Observable(-1)
	
	func valid(pattern: String, input: Any?) -> Bool {
		let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
		return pred.evaluate(with: input)
	}
	
	func validPhoneNum(num: String) -> Bool {
		let pred = valid(pattern: validPattern.PhoneNumber.rawValue, input: num)
		if validThirdNum(num: num) {
			if num.count == 12 || num.count > 13 {
				return false
			} else {
				return pred
			}
		} else {
			if num.count > 12 {
				return false
			} else {
				return pred
			}
		}
	}
	
	func cleanNum(num: String) -> String {
		let phoneNum = num.replacingOccurrences(of: "-", with: "")
		return phoneNum
	}
	
	func validThirdNum(num: String) -> Bool {
		var result: String?
		if num.count > 3 {
			let stsrt =	num.index(num.startIndex, offsetBy: 2)
			let last = num.index(num.startIndex, offsetBy: 3)
			result = String(num[stsrt..<last])
		}
		
		if result == "0" {
			return true
		} else {
			return false
		}
	}
	
}


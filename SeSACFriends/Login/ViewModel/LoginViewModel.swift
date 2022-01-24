//
//  LoginViewModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/22.
//

import Foundation
import FirebaseAuth

public class LoginViewModel {
	
	static let shared = LoginViewModel()
	
	var verifyID = Observable("")
	
	let cleanPhoneNum = Observable("")
	let authNum = Observable("")
	let nickName = Observable("")
	let birth = Observable("1990-01-01")
	let year = Observable("")
	let month = Observable("")
	let day = Observable("")
	let email = Observable("")
	let gender = Observable(-1)
	
	public func validPhoneNum(num: String) -> Bool {
		let pattern = "(01[0-1])-([0-9]{3,4})-([0-9]{4})"
		let regex = try? NSRegularExpression(pattern: pattern)
		
		if validThirdNum(num: num) {
			if num.count == 12 || num.count > 13 {
				return false
			}
		} else {
			if num.count > 12 {
				return false
			}
		}

		if let _ = regex?.firstMatch(in: num, options: [], range:  NSRange(location: 0, length: num.count)) {
			return true
		} else {
			return false
		}
	}
	
	public func cleanNum(num: String) -> String {
		let phoneNum = num.replacingOccurrences(of: "-", with: "")
		return phoneNum
	}
	
	public func validThirdNum(num: String) -> Bool {
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


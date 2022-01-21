//
//  LoginViewModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/22.
//

import Foundation

public class LoginViewModel {
	
	
	
	public func validPhoneNum(num: String) -> Bool {
		let pattern = "(01[0-1])-([0-9]{3,4})-([0-9]{4})"
		let regex = try? NSRegularExpression(pattern: pattern)
		if num.count > 13 {
			return false
		}
		if let _ = regex?.firstMatch(in: num, options: [], range:  NSRange(location: 0, length: num.count)) {
			return true
		} else {
			return false
		}
	}
	
	
}

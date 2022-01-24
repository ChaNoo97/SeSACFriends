//
//  LoginViewModel+extension(BirthView).swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/23.
//

import Foundation

extension LoginViewModel {
	
	func filterDate(completion: @escaping () -> Void) {
		let date = birth.value
		let cutDate = date.split(separator: "-")
		year.value = String(cutDate[0])
		month.value = String(cutDate[1])
		day.value = String(cutDate[2])
		completion()
	}
	
	func validAge() -> Bool {
		let now = nowDate()
		let myCalendar = Calendar(identifier: .gregorian)
		let userAge = myCalendar.date(byAdding: .year, value: 17, to: stringToDate(input: birth.value))!
		if now < userAge {
			return false
		} else {
			return true
		}
	}
	
	func nowDate() -> Date {
		let dateformatter = DateFormatter()
		dateformatter.locale = Locale(identifier: "ko-KR")
		dateformatter.dateFormat = "yyyy-MM-dd"
		let now = dateformatter.string(from: Date())
		return stringToDate(input: now)
		}
	
	func dateToString(input: Date) -> String {
		let formatter = DateFormatter()
		formatter.timeStyle = .none
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.string(from: input)
	}
	
	func stringToDate(input: String) -> Date {
		let formatter = DateFormatter()
		formatter.timeStyle = .none
		formatter.timeZone = TimeZone(identifier: "UTC")
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: input)!
	}
	
	func dd(input: Date) {
		let myCalendar = Calendar(identifier: .gregorian)
		let ymd = myCalendar.dateComponents([.year, .month, .day], from: input)
		year.value = String(ymd.year!)
		month.value = String(ymd.month!)
		day.value = String(ymd.day!)
		birth.value = (year.value)+"-"+(month.value)+"-"+(day.value)
	}
	
}

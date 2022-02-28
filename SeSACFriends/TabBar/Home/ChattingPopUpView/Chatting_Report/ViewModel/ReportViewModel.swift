//
//  ReportViewModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/23.
//

import Foundation

final class ReportViweModel {
	
	var otherUid = ""
	
	var comment = ""
	
	var selectArray: Observable<[Bool]> = Observable([false, false, false, false, false, false])
	var reportArray: Observable<[Int]> = Observable([0,0,0,0,0,0])
	
	func makeReportArray() {
		for i in 0...5 {
			if selectArray.value[i] {
				reportArray.value[i] = 1
			} else {
				reportArray.value[i] = 0
			}
		}
	}
	
	func reportUser(completion: @escaping (String?, Bool?) -> Void) {

		ChatApiService.report(otherUid: otherUid, reportRepustation: reportArray.value, comment: comment) { code in
			guard let code = code else {
				return
			}
			switch StateCodeEnum(rawValue: code)! {
			case .success:
				completion(nil, true)
			case .existUser:
				completion("이미 신고 접수된 유저 입니다.", nil)
			case .fireBaseTokenError:
				FIRAuth.renewIdToken { [self] in
					ChatApiService.report(otherUid: otherUid, reportRepustation: reportArray.value, comment: comment) { code in
						guard let code = code else {
							return
						}
						switch StateCodeEnum(rawValue: code)! {
						case .success:
							completion(nil, true)
						case .existUser:
							completion("이미 신고 접수된 유저 입니다.", nil)
						default:
							return
						}
					}
				}
			default:
				print("code", code)
				return
			}
		}
	}
}

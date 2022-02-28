//
//  ReviewPopupViewModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/23.
//

import Foundation

final class ReviewPopupViewModel {
	
	var otherUid: String = ""
	var selectArray: Observable<[Bool]> = Observable([false, false, false, false, false, false])
	
	var reputationArray = [0,0,0,0,0,0,0,0,0]
	var comment = ""
	
	func makeReputationArray() {
		for i in 0...5 {
			if selectArray.value[i] {
				reputationArray[i] = 1
			} else {
				reputationArray[i] = 0
			}
		}
	}
	
	func review(completion: @escaping() -> Void) {
		ChatApiService.review(otherUid: otherUid, reputation: reputationArray, comment: comment) { code in
			guard let code = code else {
				return
			}
			print("code", code)
			switch StateCodeEnum(rawValue: code)! {
			case .success:
				completion()
			case .fireBaseTokenError:
				FIRAuth.renewIdToken {
					ChatApiService.review(otherUid: self.otherUid, reputation: self.reputationArray, comment: self.comment) { code in
						guard let code = code else {
							return
						}
						switch StateCodeEnum(rawValue: code)! {
						case .success:
							completion()
						default:
							return
						}
					}
				}
			default:
				return
			}
		}
	}
	
}

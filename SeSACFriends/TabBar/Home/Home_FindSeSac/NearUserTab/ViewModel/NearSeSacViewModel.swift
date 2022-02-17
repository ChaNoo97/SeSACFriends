//
//  NearSeSacViewModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/15.
//

import Foundation
import UIKit

final class NearSeSacViewModel {
	
	var boolArray = Array(repeating: true, count: 5)
	
	func deleteQueue(completion: @escaping (String?, UIViewController?) -> Void) {
		QueueApiService.deleteQueue { code in
			guard let code = code else {
				return
			}
			switch StateCodeEnum(rawValue: code)! {
			case .success:
				completion(nil, TabBarController())
			case .existUser:
				completion("누군가와 취미를 함께하기로 약속하셨어요!", nil/*(채팅뷰컨)*/)
			case .fireBaseTokenError:
				FIRAuth.renewIdToken {
					QueueApiService.deleteQueue { code in
						guard let code = code else {
							return
						}
						switch StateCodeEnum(rawValue: code)! {
						case .success:
							completion(nil, HomeViewController())
						case .existUser:
							completion("누군가와 취미를 함께하기로 약속하셨어요!", nil/*(채팅뷰컨)*/)
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

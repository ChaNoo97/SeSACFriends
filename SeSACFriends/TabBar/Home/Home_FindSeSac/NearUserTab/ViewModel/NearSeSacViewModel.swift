//
//  NearSeSacViewModel.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/15.
//

import Foundation
import UIKit

final class NearSeSacViewModel {
	
	static let shared = NearSeSacViewModel()
	
	var region: Int = 0
	var lat: Double = 0
	var long: Double = 0
	
	var nearSesac: Observable<[User]> = Observable([])
	
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
	
	func onQueue(completion: @escaping () -> Void) {

		let model = OnQueueParameterModel(region: self.region, lat: self.lat, long: self.long)

		QueueApiService.onQueue(model: model) { data, code in
			guard let data = data else {
				return
			}
			switch StateCodeEnum(rawValue: code)! {
			case .success:
				self.nearSesac.value = data.fromQueueDB
				completion()
			case .fireBaseTokenError:
				FIRAuth.renewIdToken {
					QueueApiService.onQueue(model: model) { data, code in
						guard let data = data else {
							return
						}
						switch StateCodeEnum(rawValue: code)! {
						case .success:
							self.nearSesac.value = data.fromQueueDB
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

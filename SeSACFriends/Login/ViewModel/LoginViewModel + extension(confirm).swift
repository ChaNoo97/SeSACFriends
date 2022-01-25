//
//  LoginViewModel + extension(confirm).swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/22.
//

import Foundation
import FirebaseAuth

extension LoginViewModel {
	
//	public func checkAuthNum(completion: @escaping (String?,Bool) -> Void) {
//		print(#function)
//		let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyID.value , verificationCode: authNum.value)
//		
//		Auth.auth().signIn(with: credential) { success, error in
//			if error == nil {
//				//인증성공
//				print("User Sing In")
//				let currentUser = Auth.auth().currentUser
//				currentUser?.getIDTokenForcingRefresh(true, completion: { idToken, error in
//					if let error = error {
//						return;
//					}
//					completion(idToken, true)
//				})
//			} else {
//				//인증오류
//				print(error.debugDescription)
//				completion(nil, false)
//			}
//		}
//	}
}

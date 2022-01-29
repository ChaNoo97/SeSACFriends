//
//  FIRAuth.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/25.
//

import Foundation
import FirebaseAuth

class FIRAuth {
	
	static func sendAuthNum(_ cleanPhoneNum: String, completion: @escaping (String?, Error?) -> Void) {
		UserDefaults.standard.set(cleanPhoneNum, forKey: UserDefaultsKey.userPhoneNum.rawValue)
		Auth.auth().languageCode = "ko"
		PhoneAuthProvider.provider().verifyPhoneNumber(cleanPhoneNum, uiDelegate: nil) { varification, error in
			if error == nil {
				UserDefaults.standard.set(varification!, forKey: UserDefaultsKey.varification.rawValue)
				completion(varification, nil)
			} else {
				completion(nil, error)
			}
		}
	}
	
	static func checkAuthNum(authNum: String, completion: @escaping (String?,Bool) -> Void) {
		guard let varification = UserDefaults.standard.string(forKey: UserDefaultsKey.varification.rawValue) else { return }
		let credential = PhoneAuthProvider.provider().credential(withVerificationID: varification, verificationCode: authNum)
	   
	   Auth.auth().signIn(with: credential) { success, error in
		   if error == nil {
			   //인증성공
			   print("User Sing In")
			   let currentUser = Auth.auth().currentUser
			   currentUser?.getIDTokenForcingRefresh(true, completion: { idToken, error in
				   if let error = error {
					   print(#function, error)
					   return;
				   }
				   completion(idToken, true)
			   })
		   } else {
			   //인증오류
			   print(error.debugDescription)
			   completion(nil, false)
		   }
	   }
   }
	
	static func renewIdToken() {
		print("firauthrenewidtoken")
		let currentUser = Auth.auth().currentUser
		currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
		  if let error = error {
			print(#function, error)
			return;
		  }
			UserDefaults.standard.set(idToken, forKey: UserDefaultsKey.idToken.rawValue)
			
		}
	}
	
}

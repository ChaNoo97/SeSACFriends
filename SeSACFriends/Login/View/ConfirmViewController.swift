//
//  ConfirmViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/21.
//

import UIKit
import FirebaseAuth
import Toast

public class ConfirmViewController: LoginBaseViewController {
	
	let mainView = ConfirmView()
	let viewModel = LoginViewModel.shared
	var limitTime: Int = 60
	
	public override func loadView() {
		self.view = mainView
		mainView.repeatButton.isEnabled = false
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		sendAuthNum()
		mainView.authTextField.textField.keyboardType = .phonePad
		mainView.authTextField.textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
		mainView.repeatButton.addTarget(self, action: #selector(repeatButtonClicked), for: .touchUpInside)
		mainView.mainButton.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
		makeTabGester(view: view, target: self, action: #selector(dismissKeyboard))
	}
	
	public func sendAuthNum() {
		Auth.auth().languageCode = "ko"
		PhoneAuthProvider.provider().verifyPhoneNumber((viewModel.cleanPhoneNum.value), uiDelegate: nil) { varification, error in
			if error == nil {
				self.viewModel.verifyID.value = varification!
				self.getSetTime()
				self.view.makeToast("인증번호를 보냈습니다.")
			} else {
				//분기처리
				print("Phone Varification Error: \(error.debugDescription)")
				self.view.makeToast("오류가 발생했습니다.")
			}
		}
	}
	
	@objc func repeatButtonClicked() {
		limitTime = 60
		sendAuthNum()
	}
	
	@objc func mainButtonClicked() {
		dismissKeyboard()
		if limitTime == 0 {
			view.makeToast("전화 번호 인증 실패")
			return
		}
		
		if mainView.mainButton.type == .fill {
			viewModel.checkAuthNum { idToken, success in
				if success {
					UserDefaults.standard.set(idToken, forKey: UserDefaultKeyEnum.idToken.rawValue)
					//get user -200 -201 
					self.pushViewCon(vc: NickNameViewController())
				} else {
					self.view.makeToast("에러가 발생했습니다.\n잠시후 다시 시도해주세요.")
				}
			}
		} else {
			view.makeToast("인증번호를 확인해 주세요.")
		}
	}
	
	@objc func textFieldChanged() {
		let text = mainView.authTextField.textField.text!
		mainView.authTextField.setupType(type: .active)
		viewModel.authNum.value = text
		if viewModel.valid(pattern: validPattern.AuthNumber.rawValue, input: text) {
			mainView.mainButton.setupButtonType(type: .fill)
			mainView.authTextField.setupType(type: .success)
			mainView.authTextField.notiLabel.text = ""
		} else {
			mainView.mainButton.setupButtonType(type: .disable)
		}
	}
	
	//타이머도 뷰모델에서 해주고싶은데 모르겟음
	@objc func getSetTime() {
		secToTime(sec: limitTime)
		limitTime -= 1
	}
	
	func secToTime(sec: Int) {
		let minute = (sec % 3600) / 60
		let second = (sec % 3600) % 60
		if second < 10 {
			mainView.timerLabel.text = String(minute)+":"+"0"+String(second)
		} else {
			mainView.timerLabel.text = String(minute)+":"+String(second)
		}
		
		if limitTime >= 0 {
			perform(#selector(getSetTime), with: nil, afterDelay: 1.0)
		}
		
		if limitTime <= 40 {
			mainView.repeatButton.setupButtonType(type: .fill)
			mainView.repeatButton.isEnabled = true
		}
	}
}



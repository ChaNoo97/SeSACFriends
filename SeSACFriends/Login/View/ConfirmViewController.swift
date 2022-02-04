//
//  ConfirmViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/21.
//

import UIKit
import FirebaseAuth
import Toast

final class ConfirmViewController: BaseViewController {
	
	let mainView = ConfirmView()
	let viewModel = LoginViewModel.shared
	var limitTime: Int = 60
	var timer: Timer?
	
	override func loadView() {
		self.view = mainView
		mainView.repeatButton.isEnabled = false
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		sendAuthNum()
		mainView.authTextField.textField.keyboardType = .phonePad
		mainView.authTextField.textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
		mainView.repeatButton.addTarget(self, action: #selector(repeatButtonClicked), for: .touchUpInside)
		mainView.mainButton.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
		makeTabGester(view: view, target: self, action: #selector(dismissKeyboard))
	}
	
	func sendAuthNum() {
		FIRAuth.sendAuthNum(viewModel.cleanPhoneNum.value) { varification, error in
			if error == nil {
				self.startTimer()
				self.view.makeToast("인증번호를 보냈습니다.")
			} else {
				let state = AuthErrorCode(rawValue: error!._code)
				print("Phone Varification Error: \(error.debugDescription)")
				switch state {
				case .tooManyRequests:
					self.view.makeToast("요청과다.\n잠시후 다시 시도해주세요.")
				default:
					self.view.makeToast("오류가 발생했습니다.")
				}
			}
		}
	}
	
	@objc func repeatButtonClicked() {
		mainView.repeatButton.setupButtonType(type: .disable)
		mainView.repeatButton.isEnabled = false
		limitTime = 60
		startTimer()
		sendAuthNum()
	}
	
//	mainView.mainButton.isEnabled = false
	@objc func mainButtonClicked() {
		self.mainView.mainButton.isEnabled = false
		dismissKeyboard()
		if limitTime == 0 {
			view.makeToast("전화 번호 인증 실패")
			return
		}
		
		if mainView.mainButton.type == .fill {
			FIRAuth.checkAuthNum(authNum: viewModel.authNum.value) { idToken, success in
				if success {
					UserDefaults.standard.set(idToken, forKey: UserDefaultsKey.idToken.rawValue)
					self.changeRootNavView(viewController: NickNameViewController())
				} else {
					self.view.makeToast("에러가 발생했습니다.\n잠시후 다시 시도해주세요.")
					self.mainView.mainButton.isEnabled = true
				}
			}
		} else {
			view.makeToast("전화 번호 인증 실패")
			self.mainView.mainButton.isEnabled = true
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
	
	func startTimer() {
		if timer != nil && timer!.isValid {
			timer!.invalidate()
		}
		
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
	}
	
	@objc func timerCallBack() {
		let min = (limitTime % 3600) / 60
		let sec = (limitTime % 3600) % 60
		if limitTime != 60 {
			mainView.timerLabel.text = "00:\(sec)"
			if limitTime < 40 {
				mainView.repeatButton.setupButtonType(type: .fill)
				mainView.repeatButton.isEnabled = true
				if limitTime < 10 {
					mainView.timerLabel.text = "00:0\(sec)"
					if limitTime == 0 {
						timer?.invalidate()
						timer = nil
					}
				}
			}
		} else {
			mainView.timerLabel.text = "0\(min):00"
		}
		if limitTime != 0 {
			limitTime -= 1
		}
	}
	
}



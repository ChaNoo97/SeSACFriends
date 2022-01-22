//
//  LoginViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/21.
//

import UIKit
import SnapKit
import FirebaseAuth
import Toast

public class LoginViewController: BaseViewController {
	
	let mainView = LoginView()
	let viewModel = LoginViewModel.shared
	
	public override func loadView() {
		self.view = mainView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		mainView.button.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
		makeTabGester(view: view, target: self, action: #selector(dissmissKeyboard))
		mainView.phoneNumberTextField.textField.delegate = self
		mainView.phoneNumberTextField.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
	}
	
	@objc func textFieldDidChange(_ textField: UITextField) {
		if viewModel.validPhoneNum(num: textField.text!) {
			mainView.button.setupButtonType(type: .fill)
			mainView.phoneNumberTextField.setupType(type: .success)
			mainView.phoneNumberTextField.notiLabel.text = "올바른 형식입니다."
			viewModel.cleanPhoneNum.value = viewModel.cleanNum(num: textField.text!)
		} else {
			mainView.phoneNumberTextField.setupType(type: .error)
			mainView.phoneNumberTextField.notiLabel.text = "올바르지 않은 형식입니다."
			mainView.button.setupButtonType(type: .cancel)
		}
	}
	
	@objc func dissmissKeyboard() {
		self.view.endEditing(true)
	}
	
	@objc func mainButtonClicked() {
		view.endEditing(true)
		if mainView.button.type == .fill {
			pushViewCon(vc: ConfirmViewController())
		} else {
			view.makeToast("잘못된 전화번호 형식입니다.")
		}
	}
	
}

extension LoginViewController: UITextFieldDelegate {
	public func textFieldDidChangeSelection(_ textField: UITextField) {
		let phoneNum = textField.text!
		if phoneNum != "" {
			mainView.phoneNumberTextField.setupType(type: .active)
			let userPhoneNum = phoneNum
			textField.text = userPhoneNum.pretty()
		} else {
			mainView.phoneNumberTextField.setupType(type: .inactive)
		}
	}
}

extension String {
	func pretty() -> String {
		let str = self.replacingOccurrences(of: "-", with: "")
		let arr = Array(str)
		if arr.count > 3 {
			if let regex = try? NSRegularExpression(pattern: "(01[0-1]{1})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
				let modString = regex.stringByReplacingMatches(in: str, options: [], range: NSRange(str.startIndex..., in: str), withTemplate: "$1-$2-$3")
				return modString
			}
		}
		return self
	}
}

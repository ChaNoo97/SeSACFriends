//
//  emailViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/23.
//

import UIKit
import SnapKit

final class EmailViewController: BaseViewController {
	
	let mainView = emailView()
	let viewModel = LoginViewModel.shared
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mainView.mainButton.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
		mainView.emailTextField.textField.addTarget(self, action: #selector(emailTextfieldChanged(_:)), for: .editingChanged)
		mainView.emailTextField.textField.becomeFirstResponder()
		makeTabGester(view: view, target: self, action: #selector(dismissKeyboard))
		viewModel.email.bind { value in
			self.mainView.emailTextField.textField.text = value
		}
	}
	
	@objc func emailTextfieldChanged(_ textField: UITextField) {
		guard let text = textField.text else { return }
		let valid = viewModel.valid(pattern: validPattern.Email.rawValue, input: text)
		if valid {
			mainView.mainButton.setupButtonType(type: .fill)
			mainView.emailTextField.setupType(type: .success)
			viewModel.email.value = text
			mainView.emailTextField.notiLabel.text = "올바른 형식입니다."
		} else {
			mainView.mainButton.setupButtonType(type: .disable)
			mainView.emailTextField.setupType(type: .error)
			mainView.emailTextField.notiLabel.text = "올바르지 않은 형식입니다."
		}
	}
	
	@objc func mainButtonClicked() {
		let status = mainView.mainButton.type
		if status == .fill {
			pushViewCon(vc: GenderViewController())
		} else {
			dismissKeyboard()
			view.makeToast("이메일 형식이 올바르지 않습니다.")
		}
		
	}
		
}

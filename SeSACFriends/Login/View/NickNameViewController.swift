//
//  NickNameViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/22.
//

import Foundation
import UIKit

final class NickNameViewController: BaseViewController {
	
	let mainView = NickNameVeiw()
	let viewModel = LoginViewModel.shared
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print(UserDefaults.standard.string(forKey: UserDefaultsKey.FCMtoken.rawValue))
		mainView.mainButton.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
		makeTabGester(view: view, target: self, action: #selector(dismissKeyboard))
		mainView.nickNameTextField.textField.addTarget(self, action: #selector(nickNameTextfieldChange(_:)), for: .editingChanged)
		mainView.nickNameTextField.textField.becomeFirstResponder()
	}
	
	@objc func mainButtonClicked() {
		dismissKeyboard()
		let buttonStatus = mainView.mainButton.type
		if buttonStatus == .fill {
			pushViewCon(vc: BirthViewController())
		} else {
			view.makeToast("닉네임을 확인해 주세요")
		}
	}
	
	@objc func nickNameTextfieldChange(_ textfield: UITextField) {
		let textField = mainView.nickNameTextField
		guard let text = textfield.text else { return }
		let valid = viewModel.valid(pattern: validPattern.NickName.rawValue, input: text)
		if !valid {
			textField.setupType(type: .error)
			textField.notiLabel.text = "글자수를 체크해 주세요"
			mainView.mainButton.setupButtonType(type: .disable)
		} else {
			textField.setupType(type: .success)
			textField.notiLabel.text = "사용 가능한 닉네임 입니다."
			mainView.mainButton.setupButtonType(type: .fill)
			viewModel.nickName.value = text
		}
	}
	
}

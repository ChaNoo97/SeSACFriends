//
//  BirthViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/23.
//

import UIKit
import SnapKit

final class BirthViewController: BaseViewController {
	
	let mainView = BirthView()
	let viewModel = LoginViewModel.shared
	
	let datePicker = UIDatePicker()
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		changeValue()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		mainView.yearView.textField.textField.becomeFirstResponder()
		createDatePickerView()
		makeTabGester(view: view, target: self, action: #selector(dismissKeyboard))
		navigationBarSetting()
		mainView.mainButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
	}
	
	@objc func buttonClicked() {
		let status = mainView.mainButton.type
		if status == .fill {
			pushViewCon(vc: EmailViewController())
		} else {
			dismissKeyboard()
			view.makeToast("새싹친구는 만 17세 이상만 사용할 수 있습니다.")
		}
	}
	
	func createDatePickerView() {
		datePicker.preferredDatePickerStyle = .wheels
		datePicker.datePickerMode = .date
		datePicker.date = viewModel.stringToDate(input: viewModel.birth.value)
		datePicker.locale = Locale(identifier: "ko-KR")
		datePicker.addTarget(self, action: #selector(changeValue), for: .valueChanged)
		datePicker.maximumDate = Date()
		mainView.yearView.textField.textField.inputView = datePicker
		mainView.monthView.textField.textField.inputView = datePicker
		mainView.dayView.textField.textField.inputView = datePicker
	}
	
	@objc func changeValue() {
		viewModel.joinBirthData(input: datePicker.date)
		viewModel.year.bind {
			self.mainView.yearView.textField.textField.text = $0
		}
		viewModel.month.bind {
			self.mainView.monthView.textField.textField.text = $0
		}
		viewModel.day.bind {
			self.mainView.dayView.textField.textField.text = $0
		}
		
		if viewModel.validAge() {
			mainView.mainButton.setupButtonType(type: .fill)
		} else {
			mainView.mainButton.setupButtonType(type: .disable)
		}
	}
	
}


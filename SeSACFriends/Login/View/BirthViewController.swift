//
//  BirthViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/23.
//

import UIKit
import SnapKit

public class BirthViewController: LoginBaseViewController {
	
	let mainView = BirthView()
	let viewModel = LoginViewModel.shared
	
	let datePicker = UIDatePicker()
	
	public override func loadView() {
		self.view = mainView
	}
	
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		changeValue()
	}
	public override func viewDidLoad() {
		super.viewDidLoad()
		mainView.yearView.textField.textField.becomeFirstResponder()
		createDatePickerView()
		makeTabGester(view: view, target: self, action: #selector(dismissKeyboard))
		navigationBarSetting()
		mainView.button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
	}
	
	@objc func buttonClicked() {
		pushViewCon(vc: EmailViewController())
	}
	
	func createDatePickerView() {
		print(#function)
		datePicker.preferredDatePickerStyle = .wheels
		datePicker.datePickerMode = .date
		datePicker.date = viewModel.stringToDate(input: viewModel.birth.value)
		datePicker.locale = Locale(identifier: "ko-KR")
		datePicker.addTarget(self, action: #selector(changeValue), for: .valueChanged)
		mainView.yearView.textField.textField.inputView = datePicker
		mainView.monthView.textField.textField.inputView = datePicker
		mainView.dayView.textField.textField.inputView = datePicker
	}
	
	@objc func changeValue() {
		viewModel.dd(input: datePicker.date)
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
			mainView.button.setupButtonType(type: .fill)
		} else {
			mainView.button.setupButtonType(type: .disable)
		}
	}
	
}


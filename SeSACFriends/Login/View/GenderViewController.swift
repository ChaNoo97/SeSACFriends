//
//  GenderViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/24.
//

import UIKit
import SnapKit

public class GenderViewController: LoginBaseViewController {
	
	let mainView = GenderView()
	let viewModel = LoginViewModel.shared
	var manBtnStatus = false
	var womanBtnStatus = false
	
	
	public override func loadView() {
		self.view = mainView
	}
	
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if viewModel.gender.value == 1 {
			manButtonClicked()
		} else if viewModel.gender.value == 0 {
			womanButtonClicked()
		}
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		mainView.manButton.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
		mainView.womanButton.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
	}
	
	@objc func manButtonClicked() {
		manBtnStatus.toggle()
		if manBtnStatus {
			mainView.manButton.setupButtonType(type: .select)
			mainView.button.setupButtonType(type: .fill)
			viewModel.gender.value = 1
			if womanBtnStatus {
				womanBtnStatus.toggle()
				mainView.womanButton.setupButtonType(type: .unSelect)
			}
		} else {
			mainView.manButton.setupButtonType(type: .unSelect)
			viewModel.gender.value = -1
		}
	}
	
	@objc func womanButtonClicked() {
		womanBtnStatus.toggle()
		if womanBtnStatus {
			mainView.womanButton.setupButtonType(type: .select)
			mainView.button.setupButtonType(type: .fill)
			viewModel.gender.value = 0
			if manBtnStatus {
				mainView.manButton.setupButtonType(type: .unSelect)
				manBtnStatus.toggle()
			}
		} else {
			mainView.womanButton.setupButtonType(type: .unSelect)
			viewModel.gender.value = -1
		}
	}
	
	
	
}

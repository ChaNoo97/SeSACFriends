//
//  GenderViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/24.
//

import UIKit
import SnapKit

final class GenderViewController: BaseViewController {
	
	let mainView = GenderView()
	let viewModel = LoginViewModel.shared
	var manBtnStatus = false
	var womanBtnStatus = false
	
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if viewModel.gender.value == 1 {
			manButtonClicked()
		} else if viewModel.gender.value == 0 {
			womanButtonClicked()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mainView.manButton.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
		mainView.womanButton.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
		mainView.mainButton.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
	}
	
	@objc func mainButtonClicked() {
		viewModel.signUP { stausCode, error in
			if error != nil {
				return
			}
			
			if let stausCode = stausCode {
				print(stausCode)
				switch stausCode {
				case 200:
					self.view.makeToast("회원가입 완료\n홈 화면으로 이동합니다.")
					DispatchQueue.main.asyncAfter(deadline: .now()+1) {
						self.changeRootView(viewController: withdrawViewController())
					}
				case 201:
					self.view.makeToast("이미 가입한 회원입니다.")
				case 202:
					self.view.makeToast("사용할수 없는 닉네임 입니다.\n닉네임 재설정 화면으로 이동합니다.")
					DispatchQueue.main.asyncAfter(deadline: .now()+1) {
						self.navigationController?.popToRootViewController(animated: true)
					}
				case 401:
					FIRAuth.renewIdToken()
					self.viewModel.signUP { statusCode, error in
						if error != nil {
							self.view.makeToast("회원가입 실패.\n잠시후 다시 시도해 주세요.")
							return
						}
						if let statusCode = statusCode {
							switch statusCode {
							case 200:
								self.view.makeToast("회원가입 완료\n홈 화면으로 이동합니다.")
								UserDefaults.standard.set(true, forKey: UserDefaultsKey.joinFriends.rawValue)
								DispatchQueue.main.asyncAfter(deadline: .now()+1) {
									self.changeRootView(viewController: withdrawViewController())
								}
							case 201:
								self.view.makeToast("이미 가입한 회원입니다.")
							case 202:
								self.view.makeToast("사용할수 없는 닉네임 입니다.\n닉네임 재설정 화면으로 이동합니다.")
								DispatchQueue.main.asyncAfter(deadline: .now()+1) {
									self.navigationController?.popToRootViewController(animated: true)
								}
							case 401:
								self.view.makeToast("회원가입 실패.\n잠시후 다시 시도해 주세요.")
							default:
								self.view.makeToast("서버에 오류가 있습니다.\n잠시후 다시 시도해 주세요.")
							}
						}
					}
				default:
					self.view.makeToast("서버에 오류가 있습니다.\n잠시후 다시 시도해 주세요.")
				}
			}
		}
	}
	
	@objc func manButtonClicked() {
		manBtnStatus.toggle()
		if manBtnStatus {
			mainView.manButton.setupButtonType(type: .select)
			mainView.mainButton.setupButtonType(type: .fill)
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
			mainView.mainButton.setupButtonType(type: .fill)
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

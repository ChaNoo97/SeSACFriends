//
//  MyInfoManageViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/02.
//

import UIKit
import SnapKit
import MultiSlider

final class MyInfoManageViewController: BaseViewController {
	
	let mainView = MyInfoManageView()
	let viewModel = MyInfoManageViewModel()
	
	var profileIsOpen = true
	var isMan = false
	var isWoman = false
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		tabBarHidden()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationBarSetting()
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveBtnTapped))
		makeTabGester(view: mainView, target: self, action: #selector(dismissKeyboard))
		navigationBarSetTitle(title: "내 정보")
		viewModel.callUserInfo {
			self.bindValue()
			self.bindUserInfo()
		}
		mainView.myInfoCardView.userTitle.arrowButton.addTarget(self, action: #selector(arrowBtnClicked), for: .touchUpInside)
		mainView.bottomView.slider.addTarget(self, action: #selector(sliderChange(_:)), for: .valueChanged)

		mainView.bottomView.manButton.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
		mainView.bottomView.womanButton.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
		mainView.bottomView.activeSwitch.addTarget(self, action: #selector(activeSwitchChanged), for: .valueChanged)
		mainView.bottomView.hobbyTextField.textField.addTarget(self, action: #selector(hobbyTextFieldChagnged), for: .editingChanged)
		mainView.bottomView.withdrawButton.addTarget(self, action: #selector(withdrawButtonClicked), for: .touchUpInside)
    }
	
	func bindUserInfo() {
		
		mainView.myInfoCardView.userTitle.nameLabel.text = viewModel.userInfo.value.nick
		viewModel.checkReview { review, count in
			if count == 0 {
				self.mainView.myInfoCardView.reviewView.moreButton.isHidden = true
			} else if count == 1 {
				self.mainView.myInfoCardView.reviewView.moreButton.isHidden = true
				self.mainView.myInfoCardView.reviewView.reviewLabel.text = review
			} else {
				self.mainView.myInfoCardView.reviewView.moreButton.isHidden = false
				self.mainView.myInfoCardView.reviewView.reviewLabel.text = review
			}
		}
		setUpReputationLabel()
		
	}
	
	func bindValue() {
		
		viewModel.age.bind { age in
			self.mainView.bottomView.otherAgeNumberLabel.text = "\(age[0])-\(age[1])"
			self.mainView.bottomView.slider.value = [CGFloat(age[0]), CGFloat(age[1])]
		}
		
		viewModel.userInfo.bind {
			if $0.gender == 0 {
				self.isWoman.toggle()
				print(self.isWoman)
			} else if $0.gender == 1 {
				self.isMan.toggle()
			}
			self.setUpGenderButton()

		}
		
		viewModel.permissionMynum.bind {
			let allow = $0
			if allow == 1 {
				self.mainView.bottomView.activeSwitch.isOn = true
			} else {
				self.mainView.bottomView.activeSwitch.isOn = false
			}
		}
		
		viewModel.hobby.bind {
			self.mainView.bottomView.hobbyTextField.textField.text = $0
		}
		
	}
	
	func setUpGenderButton() {
		if isMan {
			mainView.bottomView.manButton.setupButtonType(type: .select)
		} else if isWoman {
			mainView.bottomView.womanButton.setupButtonType(type: .select)
		}
	}
	
	func setUpReputationLabel() {
		let reputationView = mainView.myInfoCardView.reputationView
		let reputationLableArray = [
			reputationView.reputationLabel1,
			reputationView.reputationLabel2,
			reputationView.reputationLabel3,
			reputationView.reputationLabel4,
			reputationView.reputationLabel5,
			reputationView.reputationLabel6
		]
		for i in 0...5 {
			reputationView.setUpReputationLabel(num: viewModel.userInfo.value.reputation[i], reputationLabel: reputationLableArray[i])
		}
	}
	
	@objc func activeSwitchChanged() {
		let status = mainView.bottomView.activeSwitch.isOn
		if status {
			viewModel.permissionMynum.value = 1
		} else {
			viewModel.permissionMynum.value = 0
		}
	}
	
	@objc func sliderChange(_ slider: MultiSlider) {
		let minAge = Int(slider.value[0])
		let maxAge = Int(slider.value[1])
		mainView.bottomView.otherAgeNumberLabel.text = "\(minAge)-\(maxAge)"
		viewModel.age.value = [minAge, maxAge]
	}
	
	@objc func manButtonClicked() {
		if isWoman {
			mainView.bottomView.manButton.setupButtonType(type: .select)
			mainView.bottomView.womanButton.setupButtonType(type: .unSelect)
			isMan.toggle()
			isWoman.toggle()
			viewModel.gender.value = 1
		}
	}
	
	@objc func womanButtonClicked() {
		if isMan {
			mainView.bottomView.womanButton.setupButtonType(type: .select)
			mainView.bottomView.manButton.setupButtonType(type: .unSelect)
			isMan.toggle()
			isWoman.toggle()
			viewModel.gender.value = 0
		}
	}
    
	@objc func arrowBtnClicked() {
		if profileIsOpen {
			mainView.myInfoCardView.reputationView.isHidden = true
			mainView.myInfoCardView.reviewView.isHidden = true
			mainView.myInfoCardView.userTitle.arrowButton.setImage(UIImage(named: "upArrow"), for: .normal)
		} else {
			mainView.myInfoCardView.reputationView.isHidden = false
			mainView.myInfoCardView.reviewView.isHidden = false
			mainView.myInfoCardView.userTitle.arrowButton.setImage(UIImage(named: "downArrow"), for: .normal)
		}
		profileIsOpen.toggle()
		
	}
	
	@objc func hobbyTextFieldChagnged() {
		viewModel.hobby.value =  mainView.bottomView.hobbyTextField.textField.text!
	}
	
	@objc func saveBtnTapped() {
		if viewModel.checkChange() {
			viewModel.updateMypage { message in
				self.view.makeToast(message)
			}
		} else {
			self.view.makeToast("변경사항이 없습니다.")
		}
	}
	
	@objc func withdrawButtonClicked() {
		let vc = WithdrawViewController()
		vc.modalPresentationStyle = .overCurrentContext
		vc.modalTransitionStyle = .crossDissolve
		present(vc, animated: true, completion: nil)
	}

}

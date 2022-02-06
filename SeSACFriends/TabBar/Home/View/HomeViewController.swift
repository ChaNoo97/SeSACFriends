//
//  HomeViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/27.
//

import UIKit
import SnapKit

final class HomeViewController: BaseViewController {
	
	let mainView = HomeView()
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.navigationBar.isHidden = true
		self.navigationController?.navigationBar.isTranslucent = true
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationBarSetTitle(title: "홈")
		mainView.allButton.addTarget(self, action: #selector(allButtonClicked), for: .touchUpInside)
		mainView.manButton.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
		mainView.womanButton.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
		
	}
	
	@objc func allButtonClicked() {
		mainView.changeGenderButton(button: mainView.allButton, label: mainView.allLabel, type: .select)
		mainView.changeGenderButton(button: mainView.manButton, label: mainView.manLabel, type: .unSelect)
		mainView.changeGenderButton(button: mainView.womanButton, label: mainView.womanLabel, type: .unSelect)
	}
	
	@objc func manButtonClicked() {
		mainView.changeGenderButton(button: mainView.allButton, label: mainView.allLabel, type: .unSelect)
		mainView.changeGenderButton(button: mainView.manButton, label: mainView.manLabel, type: .select)
		mainView.changeGenderButton(button: mainView.womanButton, label: mainView.womanLabel, type: .unSelect)
	}
	
	@objc func womanButtonClicked() {
		mainView.changeGenderButton(button: mainView.womanButton, label: mainView.womanLabel, type: .select)
		mainView.changeGenderButton(button: mainView.manButton, label: mainView.manLabel, type: .unSelect)
		mainView.changeGenderButton(button: mainView.allButton, label: mainView.allLabel, type: .unSelect)
	}
}

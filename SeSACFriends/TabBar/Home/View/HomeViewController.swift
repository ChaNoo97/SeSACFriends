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
		mainView.allButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
		mainView.manButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
		mainView.womanButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
		
	}
	
	@objc func buttonClicked(_ sender: UIButton) {
		switch sender.tag {
		case 0:
			mainView.selectAllButton()
		case 1:
			mainView.selectManButton()
		case 2:
			mainView.selectWomanButton()
		default:
			break
		}
	}
	
}

//
//  emailViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/23.
//

import UIKit
import SnapKit

public class EmailViewController: LoginBaseViewController {
	
	let mainView = emailView()
	let viewModel = LoginViewModel.shared
	
	public override func loadView() {
		self.view = mainView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		mainView.button.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
	}
	
	@objc func mainButtonClicked() {
		pushViewCon(vc: GenderViewController())
	}
		
}

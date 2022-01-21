//
//  LoginViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/21.
//

import UIKit
import SnapKit

public class LoginViewController: BaseViewController {
	
	let mainView = LoginView()
	
	public override func loadView() {
		self.view = mainView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		mainView.button.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
	}
	
	@objc func mainButtonClicked() {
//		let vc = ConfirmViewController()
//		navigationController?.pushViewController(vc, animated: true)
	}
	
}

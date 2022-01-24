//
//  NickNameViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/22.
//

import Foundation

public class NickNameViewController: LoginBaseViewController {
	
	let mainView = NickNameVeiw()
	
	public override func loadView() {
		self.view = mainView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		mainView.button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
		makeTabGester(view: view, target: self, action: #selector(dismissKeyboard))
	}
	
	@objc func buttonClicked() {
		pushViewCon(vc: BirthViewController())
	}
	
}

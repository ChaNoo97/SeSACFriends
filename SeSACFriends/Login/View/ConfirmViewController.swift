//
//  ConfirmViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/21.
//

import UIKit

public class ConfirmViewController: BaseViewController {
	
	let mainView = ConfirmView()
	
	public override func loadView() {
		self.view = mainView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
	}
	
}



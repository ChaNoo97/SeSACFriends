//
//  BaseViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/21.
//

import UIKit

public class BaseViewController: UIViewController {
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		configure()
		navigationBarSetting()
	}
	
	fileprivate func configure() {
		view.backgroundColor = .white
	}
	
	public func navigationBarSetting() {
		navigationController?.navigationBar.topItem?.title = ""
		navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
		navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
		navigationController?.navigationBar.tintColor = .sesacBlack
	}
	
	public func navigationBarSetTitle(title: String) {
		navigationItem.title = title
	}
	
}

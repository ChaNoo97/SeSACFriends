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
	}
	
	fileprivate func configure() {
		view.backgroundColor = .white
	}
	
}

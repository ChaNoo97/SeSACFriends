//
//  BaseViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/21.
//

import UIKit

protocol BaseViewCon {
	func viewDidLoad()
	func configure()
	func navigationBarSetting()
	func navigationBarSetTitle(title: String)
	func makeTabGester(view: UIView, target: Any?, action: Selector?)
}

public class BaseViewController: UIViewController, BaseViewCon {
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		configure()
		navigationBarSetting()
	}
	
	public func configure() {
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
	
	public func makeTabGester(view: UIView, target: Any?, action: Selector?) {
		let tap = UITapGestureRecognizer(target: target, action: action)
		view.addGestureRecognizer(tap)
	}
	
	public func pushViewCon(vc: UIViewController) {
		navigationController?.pushViewController(vc, animated: true)
	}
	
}

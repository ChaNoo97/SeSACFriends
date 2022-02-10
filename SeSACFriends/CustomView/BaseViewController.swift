//
//  BaseViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/21.
//

import UIKit

class BaseViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configure()
		navigationBarSetting()
	}
}

extension UIViewController {
	func configure() {
		view.backgroundColor = .white
	}
	
	func navigationBarSetting() {
		navigationController?.navigationBar.topItem?.title = ""
		navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
		navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
		navigationController?.navigationBar.tintColor = .sesacBlack
	}
	
	func navigationBarSetTitle(title: String) {
		navigationItem.title = title
	}
	
	func makeTabGester(view: UIView, target: Any?, action: Selector?) {
		let tap = UITapGestureRecognizer(target: target, action: action)
		view.addGestureRecognizer(tap)
	}
	
	func pushViewCon(vc: UIViewController) {
		navigationController?.pushViewController(vc, animated: true)
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
	
	func changeRootNavView(viewController: UIViewController) {
		guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
		windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: viewController)
		windowScene.windows.first?.makeKeyAndVisible()
	}
	
	func changeRootView(viewController: UIViewController) {
		guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
		windowScene.windows.first?.rootViewController = viewController
		windowScene.windows.first?.makeKeyAndVisible()
	}
	
	func tabBarHidden() {
		self.tabBarController?.tabBar.isHidden = true
		self.tabBarController?.tabBar.isTranslucent = true
	}
	
	func tabBarDisplay() {
		self.tabBarController?.tabBar.isHidden = false
	}
	
	func navBarHidden() {
		self.navigationController?.navigationBar.isHidden = true
		self.navigationController?.navigationBar.isTranslucent = true
	}
	
	func navBarDisplay() {
		self.navigationController?.navigationBar.isHidden = false
	}
}

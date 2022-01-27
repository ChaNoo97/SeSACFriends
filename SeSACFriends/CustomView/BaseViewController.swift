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
}

extension UIViewController {
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
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
	
	public func changeRootView(viewController: UIViewController) {
		guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
		windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: viewController)
		windowScene.windows.first?.makeKeyAndVisible()
	}
}

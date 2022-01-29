//
//  TabBarController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/27.
//

import UIKit
import SnapKit

final class TabBarController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		configureTabBarController()
		setupTabBarAppearence()
	}
	
	func configureTabBarController() {
		let homeNav = makeNavigationVC(HomeViewController(), title: "홈", unSelectImage: "homeUnSelect", selectImage: "homeSelect")
		let shopNav = makeNavigationVC(ShopViewController(), title: "새싹샵", unSelectImage: "shopUnSelect", selectImage: "shopSelect")
		let friendNav = makeNavigationVC(FriendViewController(), title: "새싹친구", unSelectImage: "friendUnSelect", selectImage: "friendSelect")
		let myNav = makeNavigationVC(MyViewController(), title: "내정보", unSelectImage: "myUnSelect", selectImage: "mySelect")
		setViewControllers([homeNav, shopNav, friendNav, myNav], animated: true)
	}
	
	// iOS14 ~ 
	func setupTabBarAppearence() {
		let appearence = UITabBarAppearance()
//		appearence.configureWithTransparentBackground()
		appearence.backgroundColor = .white
		tabBar.standardAppearance = appearence
		tabBar.scrollEdgeAppearance = appearence
		tabBar.tintColor = .sesacGreen
	}
	
}

extension TabBarController {

	fileprivate func makeNavigationVC(_ viewController: UIViewController, title: String, unSelectImage: String, selectImage: String) -> UIViewController {
		viewController.tabBarItem.title = title
		viewController.tabBarItem.image = UIImage(named: unSelectImage)
		viewController.tabBarItem.selectedImage = UIImage(named: selectImage)
		return UINavigationController(rootViewController: viewController)
	}

}

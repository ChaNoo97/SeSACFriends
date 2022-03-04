//
//  ShopViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/27.
//

import UIKit
import SnapKit
import Tabman
import Pageboy

final class ShopTabViewController: TabmanViewController {
	
	private var viewControllers = [SesacShopViewController(), BackgroundShopViewController()]
	
//	let mainView = ShopView()
	let designView = UIView()
	
	
//	override func loadView() {
//		self.view = mainView
//	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationBarSetTitle(title: "새싹샵")
		self.dataSource = self
		setUpTabBarViewDesign()
	}
	
	func setUpTabBarViewDesign() {
		let bar = TMBar.ButtonBar()
		bar.layout.transitionStyle = .snap
		bar.backgroundView.style = .blur(style: .regular)
		bar.indicator.weight = .medium
		bar.indicator.tintColor = .sesacGreen
		bar.layout.view.addSubview(designView)
		designView.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview()
			$0.bottom.equalTo(bar.layout.view.snp.bottom).offset(3)
			$0.height.equalTo(1)
		}
		designView.backgroundColor = .sesacGray4
		bar.buttons.customize {
			$0.tintColor = .sesacGray4
			$0.selectedTintColor = .sesacGreen
		}
		bar.layout.contentMode = .fit
		addBar(bar, dataSource: self, at: .top)
	}
	
}

extension ShopTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
	func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
		return viewControllers.count
	}
	
	func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
		return viewControllers[index]
	}
	
	func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
		return nil
	}
	
	func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
		if index == 0 {
			return TMBarItem(title: "새싹")
		} else {
			return TMBarItem(title: "배경")
		}
	}
}
 

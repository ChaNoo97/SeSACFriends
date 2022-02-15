//
//  File.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/14.
//

import UIKit
import SnapKit
import Tabman
import Pageboy

final class FindSeSacTabViewController: TabmanViewController {
	
	private var viewControllers = [FindNearSeSacViewController(), AcceptViewController()]
	
//	let tabBarView = UIView()
	let mainView = TabBarView()
	let designView = UIView()
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
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
		addBar(bar, dataSource: self, at: .custom(view: mainView.tabBarView, layout: nil))
		
	}
	
}

extension FindSeSacTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
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
			return TMBarItem(title: "주변 새싹")
		} else {
			return TMBarItem(title: "받은 요청")
		}
	}
	
	
}

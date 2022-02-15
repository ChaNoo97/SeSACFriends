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
	
	let designView = UIView()
	let viewModel = NearSeSacViewModel()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationBarSetTitle(title: "새싹 찾기")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.dataSource = self
		setUpTabBarViewDesign()
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "찾기중단", style: .plain, target: self, action: #selector(suspendButton))
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
	
	@objc func suspendButton() {
		viewModel.deleteQueue { message, viewController in
			if let viewController = viewController {
				self.changeRootView(viewController: viewController)
//				if viewController == TabBarController() {
//					print("dhdodhodhdodhdohdodho")
//					self.changeRootView(viewController: HomeViewController())
//				} else {
//					if let message = message {
//						self.view.makeToast(message, duration: 1.0)
//						채팅뷰컨 이동
//						DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//							self.changeRootView(viewController: <#T##UIViewController#>)
//						}
//					}
//				}
			}
		}
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

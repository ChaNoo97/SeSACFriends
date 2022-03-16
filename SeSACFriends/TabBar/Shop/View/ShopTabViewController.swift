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
	let viewModel = ShopViewModel.shared
	let cardView = SesacCard()
	let saveButton = UIButton()
	let designView = UIView()
	let customContainer = UIView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationBarSetTitle(title: "새싹샵")
		self.dataSource = self
		view.backgroundColor = .white
		setUpConstraints()
		setUpConstraintCustomContainer()
		setUpTabBarViewDesign()
		saveButtonSetting()
		
		viewModel.presentBackgroundImage.bind {
			self.cardView.backgroundImageView.image = backgroundImageEnum(rawValue: $0)?.image
		}

		viewModel.presentImage.bind {
			self.cardView.faceImageView.image = sesacImageEnum(rawValue: $0)?.image
		}
		
		saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
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
		addBar(bar, dataSource: self, at: .custom(view: customContainer, layout: nil))
	}
	
	func setUpConstraintCustomContainer() {
		view.addSubview(customContainer)
		customContainer.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview()
			$0.top.equalTo(cardView.snp.bottom)
			$0.height.equalTo(43)
		}
	}
	
	func setUpConstraints() {
		view.addSubview(cardView)
		cardView.snp.makeConstraints{
			$0.top.equalTo(view.safeAreaLayoutGuide).offset(15)
			$0.height.equalTo(195)
			$0.leading.trailing.equalToSuperview()
		}
	}
	
	func saveButtonSetting() {
		cardView.addSubview(saveButton)
		saveButton.snp.makeConstraints {
			$0.trailing.equalTo(cardView.backgroundImageView.snp.trailing).inset(15)
			$0.top.equalTo(cardView.backgroundImageView.snp.top).inset(13)
			$0.height.equalTo(40)
			$0.width.equalTo(80)
		}
		saveButton.setTitle("저장하기", for: .normal)
		saveButton.setTitleColor(.sesacWhite, for: .normal)
		saveButton.titleLabel?.font = SesacFont.body3R14.font
		saveButton.backgroundColor = .sesacGreen
		saveButton.layer.cornerRadius = 8
	}
	
	@objc func saveButtonClicked() {
		viewModel.updateMyImage { message in
			self.view.makeToast(message)
		}
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
 

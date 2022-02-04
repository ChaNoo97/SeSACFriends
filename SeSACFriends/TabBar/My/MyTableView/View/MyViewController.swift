//
//  MyViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/27.
//

import UIKit
import SnapKit

final class MyViewController: BaseViewController {
	
	let mainView = MyView()
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationBarSetTitle(title: "내정보")
		mainView.tableView.delegate = self
		mainView.tableView.dataSource = self
		mainView.tableView.isScrollEnabled = false
		mainView.tableView.separatorStyle = .none
		tableCellRegister()
	}
	
	func tableCellRegister() {
		mainView.tableView.register(MyInfoCell.self, forCellReuseIdentifier: MyInfoCell.reuseIdentfier)
		mainView.tableView.register(AppInfoCell.self, forCellReuseIdentifier: AppInfoCell.reuseIdentfier)
	}
	
}

extension MyViewController: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		} else {
			return 5
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.section == 0 {
			guard let cellOfSec0 = tableView.dequeueReusableCell(withIdentifier: MyInfoCell.reuseIdentfier, for: indexPath) as? MyInfoCell else {
				return UITableViewCell()
			}
			cellOfSec0.profileName.text = "TEST"
			return cellOfSec0
		} else {
			guard let cellOfSec1 = tableView.dequeueReusableCell(withIdentifier: AppInfoCell.reuseIdentfier, for: indexPath) as? AppInfoCell else {
				return UITableViewCell()
			}
			let row = indexPath.row
			let imageArray = ["notice","faq", "qna", "setting", "permit"]
			let titleArray = ["공지 사항", "자주 묻는 질문", "1:1문의", "알림 설정", "이용 약관"]
			cellOfSec1.iconImage.image = UIImage(named: imageArray[row])
			cellOfSec1.titleLabel.text = titleArray[row]
			return cellOfSec1
		}
		
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == 0 {
			return 90
		} else {
			return 70
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath == [0, 0] {
			pushViewCon(vc: MyInfoManageViewController())
		}
	}
	
	
}

//
//  CardViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/31.
//

import UIKit
import SnapKit

class CardViewController: UIViewController {
	
	let mainView = CardView()
	var toggleStatus = false
	var cellHeight: CGFloat?
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mainView.infoTableView.register(UserInfoCell.self, forCellReuseIdentifier: UserInfoCell.reuseIdentfier)
		mainView.infoTableView.register(UserInfoTitleCell.self, forCellReuseIdentifier: UserInfoTitleCell.reuseIdentfier)
		mainView.infoTableView.delegate = self
		mainView.infoTableView.dataSource = self
		mainView.infoTableView.isScrollEnabled = false
		mainView.infoTableView.separatorStyle = .none
		mainView.infoTableView.allowsSelectionDuringEditing = false
		mainView.infoTableView.rowHeight = UITableView.automaticDimension
		mainView.infoTableView.estimatedRowHeight = UITableView.automaticDimension
	}
	
	func toggleInfoView() {
		print(toggleStatus)
		toggleStatus.toggle()
		if toggleStatus {
			mainView.infoTableView.snp.updateConstraints {
				$0.height.equalTo(58)
			}
		} else {
			print("dddd",mainView.infoTableView.contentSize.height)
			mainView.infoTableView.snp.updateConstraints {
				$0.height.equalTo(mainView.infoTableView.contentSize.height)
			}
		}
		mainView.infoTableView.reloadData()
	}
	
}

extension CardViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if toggleStatus {
			return 1
		} else {
			return 2
		}
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = indexPath.row
		if row == 0 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTitleCell.reuseIdentfier) as? UserInfoTitleCell else {
				return UITableViewCell()
			}
			if toggleStatus {
				cell.arrowImageView.image = UIImage(named: "downArrow")
//				DispatchQueue.main.async {
//					self.mainView.infoTableView.snp.updateConstraints {
//						$0.height.equalTo(58)
//					}
//				}
			} else {
				cell.arrowImageView.image = UIImage(named: "upArrow")
//				DispatchQueue.main.async {
//					self.mainView.infoTableView.snp.updateConstraints {
//						$0.height.equalTo(self.mainView.infoTableView.contentSize.height-58)
//					}
//				}
			}
			return cell
		} else {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.reuseIdentfier) as? UserInfoCell else {
				return UITableViewCell()
			}
			cell.reviewView.reviewLabel.text = "오토메틱디멘션오토메틱디멘션오토메틱디멘션오토메틱디멘션오토메틱디멘션오토메틱디멘션오토메틱디멘션오토메틱디멘션오토메틱디멘션오토메틱디멘션오토메틱디멘션오토메틱디멘션오토메틱디멘션오토메틱디멘션오토메틱디멘션오토메틱디멘션오토메틱디멘션"
//			cell.selectionStyle = .none
			
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 {
			toggleInfoView()
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return 58
		} else {
			return 300
		}

	}
}

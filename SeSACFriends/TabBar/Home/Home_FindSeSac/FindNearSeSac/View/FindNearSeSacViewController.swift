//
//  FindNearSeSacViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/15.
//

import UIKit
import SnapKit

final class FindNearSeSacViewController: UIViewController {
	
	let mainView = FindNearView()
	let viewModel = NearSeSacViewModel.shared
	var sesacs: [sesacUser] = []
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mainView.backgroundColor = .white
		print("findNearView",#function)
		tableViewSetting()
		navigationBarSetting()
		mainView.modifyHobbyButton.addTarget(self, action: #selector(modifyButtonClicked), for: .touchUpInside)
		mainView.reloadButton.addTarget(self, action: #selector(reloadButtonClicked), for: .touchUpInside)
		viewModel.onQueue {
			self.viewModel.nearSesac.bind { user in
				print(user)
				self.sesacs.removeAll()
				for i in 0...user.count-1 {
					let a = sesacUser(nick: user[i].nick, reputation: user[i].reputation, reviews: user[i].reviews, sesac: user[i].sesac, background: user[i].background)
					self.sesacs.append(a)
				}
			}
			self.mainView.tableView.reloadData()
		}
		

	}
	
	func setUpReputationView(view: ReputationView, reputationArray: [UILabel], reputationNum: [Int]) {
		for i in 0...reputationArray.count-1 {
			view.setUpReputationLabel(
				num: reputationNum[i],
				reputationLabel: reputationArray[i]
			)
		}
	}
	
	func tableViewSetting() {
		mainView.tableView.delegate = self
		mainView.tableView.dataSource = self
		mainView.tableView.register(NearSeSacTableCell.self, forCellReuseIdentifier: NearSeSacTableCell.reuseIdentfier)
		mainView.tableView.separatorStyle = .none
		mainView.tableView.rowHeight = UITableView.automaticDimension
		mainView.tableView.allowsSelection = true
	}
	
	@objc func modifyButtonClicked() {
		
	}
	
	@objc func reloadButtonClicked() {
		
	}
	
	@objc func arrowButtonClicked(_ sender: UIButton) {
		print(sender.tag)
		if self.sesacs[sender.tag].isOpen {
			self.sesacs[sender.tag].isOpen.toggle()
		} else {
			self.sesacs[sender.tag].isOpen.toggle()
		}
		mainView.tableView.reloadData()
	}
}

extension FindNearSeSacViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sesacs.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: NearSeSacTableCell.reuseIdentfier, for: indexPath) as? NearSeSacTableCell else { return UITableViewCell() }
		let row = indexPath.row
		cell.userTitle.nameLabel.text = sesacs[row].nick
		
		let reputationArray = [
			cell.reputationView.reputationLabel1,
			cell.reputationView.reputationLabel2,
			cell.reputationView.reputationLabel3,
			cell.reputationView.reputationLabel4,
			cell.reputationView.reputationLabel5,
			cell.reputationView.reputationLabel6
		]
		setUpReputationView(view: cell.reputationView, reputationArray: reputationArray, reputationNum: sesacs[row].reputation)
		cell.reviewView.reviewLabel.text = sesacs[row].reviews.first
		//나중에 추가 화면까지 구현계획 있음
		cell.reviewView.moreButton.isHidden = true
		
		if sesacs[row].isOpen {
			cell.reputationView.isHidden = true
			cell.reviewView.isHidden = true
			cell.userTitle.arrowButton.setImage(UIImage(named: "downArrow"), for: .normal)
		} else {
			cell.reputationView.isHidden = false
			cell.reviewView.isHidden = false
			cell.userTitle.arrowButton.setImage(UIImage(named: "upArrow"), for: .normal)
		}
		
		cell.userTitle.arrowButton.tag = row
		cell.userTitle.arrowButton.addTarget(self, action: #selector(arrowButtonClicked(_:)), for: .touchUpInside)

		cell.requestBtnAction = {
			print("request")
		}
		
		return cell
	}

}
	


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
	let viewModel = NearSeSacViewModel()
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//onqueue 호출
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mainView.backgroundColor = .white
		print("findNearView",#function)
		tableViewSetting()
		navigationBarSetting()
		mainView.modifyHobbyButton.addTarget(self, action: #selector(modifyButtonClicked), for: .touchUpInside)
		mainView.reloadButton.addTarget(self, action: #selector(reloadButtonClicked), for: .touchUpInside)
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
		
	}
}

extension FindNearSeSacViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: NearSeSacTableCell.reuseIdentfier, for: indexPath) as? NearSeSacTableCell else { return UITableViewCell() }
		let row = indexPath.row
		
		cell.arrowBtnAction = {
			self.mainView.tableView.reloadData()
		}
		
		cell.requestBtnAction = {
			print("request")
		}
		
		return cell
	}

}
	


//
//  AcceptViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/15.
//

import UIKit
import SnapKit

final class AcceptViewController: UIViewController {
	
	let mainView = acceptView()
	let viewModel = NearUserViewModel.shared
	
	var timer: Timer?
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		viewModel.onQueue {
			self.ButtonSetting(userCount: self.viewModel.nearSesac.recommendUser.count)
			self.mainView.tableView.reloadData()
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
		tableViewSetting()
		mainView.tableView.refreshControl = UIRefreshControl()
		mainView.tableView.refreshControl?.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
		mainView.modifyHobbyButton.addTarget(self, action: #selector(modifyButtonClicked), for: .touchUpInside)
		mainView.reloadButton.addTarget(self, action: #selector(reloadButtonClicked), for: .touchUpInside)
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		stopTimer()
	}
	
	func ButtonSetting(userCount: Int) {
		if userCount != 0 {
			mainView.modifyHobbyButton.isHidden = true
			mainView.reloadButton.isHidden = true
			mainView.emptyView.isHidden = true
		} else {
			mainView.modifyHobbyButton.isHidden = false
			mainView.reloadButton.isHidden = false
			mainView.emptyView.isHidden = false
		}
	}
	
	func tableViewSetting() {
		mainView.tableView.delegate = self
		mainView.tableView.dataSource = self
		mainView.tableView.register(AcceptTableCell.self, forCellReuseIdentifier: AcceptTableCell.reuseIdentfier)
		mainView.tableView.separatorStyle = .none
		mainView.tableView.rowHeight = UITableView.automaticDimension
		mainView.tableView.allowsSelection = false
	}
	
	func startTimer() {
		timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(checkQueueStatus), userInfo: nil, repeats: true)
 	}
	
	func stopTimer() {
		if timer != nil && timer!.isValid {
			timer!.invalidate()
		}
		timer = nil
	}
	
	@objc func modifyButtonClicked() {
		navigationController?.popViewController(animated: true)
	}
	
	@objc func reloadButtonClicked() {
		viewModel.onQueue {
			self.ButtonSetting(userCount: self.viewModel.nearSesac.recommendUser.count)
			self.mainView.tableView.reloadData()
		}
	}
	
	@objc func checkQueueStatus() {
		viewModel.myStatus(callStatus: .timer) { message, vc in
			self.view.makeToast(message)
			if let vc = vc {
				self.pushViewCon(vc: vc)
			}
		}
	}
	
	@objc func refreshTableView() {
		print("123123123123",viewModel.nearSesac)
		viewModel.onQueue {
			self.ButtonSetting(userCount: self.viewModel.nearSesac.recommendUser.count)
			self.mainView.tableView.reloadData()
		}
		self.mainView.tableView.refreshControl?.endRefreshing()
	}

	@objc func arrowButtonClicked(_ sender: UIButton) {
		print(sender.tag)
		
		if viewModel.nearSesac.recommendUser[sender.tag].isOpen {
			viewModel.nearSesac.recommendUser[sender.tag].isOpen.toggle()
		} else {
			viewModel.nearSesac.recommendUser[sender.tag].isOpen.toggle()
			viewModel.onQueue {
				self.ButtonSetting(userCount: self.viewModel.nearSesac.recommendUser.count)
			}
		}
		mainView.tableView.reloadData()
	}
	
	@objc func acceptButtonClicked(_ sender: UIButton) {
		let vc = AcceptPopUpViewController()
		vc.modalTransitionStyle = .crossDissolve
		vc.modalPresentationStyle = .overCurrentContext
		present(vc, animated: true, completion: nil)
		
		vc.acceptClosure = {
			self.viewModel.hobbyAccept(self.viewModel.nearSesac.recommendUser[sender.tag].uid) { message, ViewController in
				if let message = message {
					self.view.makeToast(message)
				} else {
					if let ViewController = ViewController {
						self.pushViewCon(vc: ViewController)
					}
				}
			}
		}
		
	}
}

extension AcceptViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.nearSesac.recommendUser.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: AcceptTableCell.reuseIdentfier, for: indexPath) as? AcceptTableCell else { return UITableViewCell() }
		let row = indexPath.row
		let user = viewModel.nearSesac.recommendUser[row]
		
		cell.userTitle.nameLabel.text = user.nick
		
		let reputationArray = [
			cell.reputationView.reputationLabel1,
			cell.reputationView.reputationLabel2,
			cell.reputationView.reputationLabel3,
			cell.reputationView.reputationLabel4,
			cell.reputationView.reputationLabel5,
			cell.reputationView.reputationLabel6
		]
		viewModel.setUpReputationView(view: cell.reputationView, reputationArray: reputationArray, reputationNum: user.reputation)
		cell.reviewView.reviewLabel.text = user.reviews.first
		//????????? ?????? ???????????? ???????????? ??????
		cell.reviewView.moreButton.isHidden = true
		
		
		if user.isOpen {
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
		
		cell.requestButton.tag = row
		cell.requestButton.addTarget(self, action: #selector(acceptButtonClicked(_:)), for: .touchUpInside)
		
		cell.backgroundImageView.image = backgroundImageEnum(rawValue: user.background)!.image
		cell.faceImageView.image = sesacImageEnum(rawValue: user.sesac)!.image
		
		return cell
	}
	
	
	
}

//
//  ChattingViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/20.
//

import UIKit
import SnapKit
import Toast

enum moreViewButton: Int {
	case report = 1
	case cancle
	case review
}

class ChattingViewController: BaseViewController {
	
	let mainView = ChattingView()
	let viewModel = ChattingViewModel.shared
	
	let placeholder = "메세지를 입력하세요"
	
	var moreViewIsHidden = true
	
	override func loadView() {
		self.view = mainView
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarHidden()
		navBarDisplay()
		mainView.contentView.text = placeholder
		mainView.contentView.textColor = .sesacGray7
		viewModel.otherNick.value = "김찬후"
		viewModel.checkMyState { message in
			if let message = message {
				self.view.makeToast(message)
			}
		}
		UserDefaults.standard.set(queueState.matched.rawValue, forKey: UserDefaultsKey.queueStatus.rawValue)
		SocketIoManager.shared.establishConnection()
		//Test
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationBarItemSetting()
		setUpTextView()
		setUpTableView()
		viewModel.otherNick.bind {
			self.navigationBarSetTitle(title: $0)
		}
		viewModel.textCount.bind {
			self.mainView.sendButton.setImage(UIImage(named: self.viewModel.sendButtonSetting($0)), for: .normal)
		}
		mainView.sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
		makeTabGester(view: mainView.tableView, target: self, action: #selector(dismissKeyboard))
		makeTabGester(view: mainView.moreView, target: self, action: #selector(tabAction))
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardShow(notification:)),
			name: UIResponder.keyboardWillChangeFrameNotification,
			object: nil)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardHide(notification:)),
			name: UIResponder.keyboardWillHideNotification,
			object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(getMessage(notification:)), name: NSNotification.Name("getMessage"), object: nil)
		moreButtonAddTarget()
		
		viewModel.otherUid.bind {
			self.viewModel.takeLastChat($0) {
				self.mainView.tableView.reloadData()
			}
		}
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name("getMessage"), object: nil)
		SocketIoManager.shared.closeConnection()
	}
	
	func moreButtonAddTarget() {
		mainView.moreView.reportButton.addTarget(self, action: #selector(actionButtonClicked(_:)), for: .touchUpInside)
		mainView.moreView.reportButton.tag = 1
		mainView.moreView.cancleButton.addTarget(self, action: #selector(actionButtonClicked(_:)), for: .touchUpInside)
		mainView.moreView.cancleButton.tag = 2
		mainView.moreView.reviewButton.addTarget(self, action: #selector(actionButtonClicked(_:)), for: .touchUpInside)
		mainView.moreView.reviewButton.tag = 3
	}
	
	func navigationBarItemSetting() {
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(backButtonClicked))
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(moreButtonClicked))
	}
	
	func setUpTextView() {
		mainView.contentView.delegate = self
	}
	
	
	func setUpTableView() {
		mainView.tableView.register(NoticeCell.self, forCellReuseIdentifier: NoticeCell.reuseIdentfier)
		mainView.tableView.register(OtherCell.self, forCellReuseIdentifier: OtherCell.reuseIdentfier)
		mainView.tableView.register(MyCell.self, forCellReuseIdentifier: MyCell.reuseIdentfier)
		mainView.tableView.delegate = self
		mainView.tableView.dataSource = self
		mainView.tableView.rowHeight = UITableView.automaticDimension
		mainView.tableView.estimatedRowHeight = UITableView.automaticDimension
		mainView.tableView.separatorStyle = .none
		
	}
	
	@objc func getMessage(notification: NSNotification) {
		print("123123")
		let chat = notification.userInfo!["chat"] as! String
		let createdAt = notification.userInfo!["createdAt"] as! String
		let from = notification.userInfo!["from"] as! String
		let to = notification.userInfo!["to"] as! String
		let value = Chat(id: "", v: 0, to: to, from: from, chat: chat, createdAt: createdAt)
		print("getMessage createdAt", createdAt)
		UserDefaults.standard.set(createdAt, forKey: UserDefaultsKey.chatLastDate.rawValue)
		
//		UserDefaults.standard.set(from, forKey: UserDefaultsKey.from.rawValue)
		viewModel.chatList.append(value)
		mainView.tableView.reloadData()
		self.mainView.tableView.scrollToRow(at: [1, self.viewModel.chatList.count-1], at: .bottom, animated: false)
	}
	
	@objc func keyboardShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			let keyboardHeight = keyboardSize.height - view.safeAreaInsets.bottom
			mainView.chatView.snp.updateConstraints {
				$0.bottom.equalTo(view.safeAreaLayoutGuide).inset(keyboardHeight)
			}
			mainView.layoutIfNeeded()
		}
	}
	
	@objc func keyboardHide(notification: NSNotification) {
		mainView.chatView.snp.updateConstraints {
			$0.bottom.equalTo(view.safeAreaLayoutGuide)
		}
		mainView.layoutIfNeeded()
	}
	
	@objc func sendButtonClicked() {
		guard let chat = mainView.contentView.text else { return }
		viewModel.validText.bind {
			if $0.count != 0 {
				self.viewModel.chatPost(chatText: chat) {
					self.mainView.tableView.reloadData()
				}
				self.mainView.contentView.text = nil
			}
		}
	}
	
	@objc func backButtonClicked() {
		print("backButtonClcked")
		navigationController?.popToRootViewController(animated: true)
	}
	
	@objc func moreButtonClicked() {
		mainView.contentView.endEditing(true)
		if moreViewIsHidden {
			UIView.animate(withDuration: 0.5) {
				self.mainView.moreView.isHidden = false
				self.mainView.moreView.stackView.alpha = 1
				self.moreViewIsHidden.toggle()
			}
			
		}
	}
	
	@objc func tabAction() {
		if !moreViewIsHidden {
			mainView.moreView.isHidden = true
			moreViewIsHidden.toggle()
			mainView.moreView.stackView.alpha = 0
		}
	}
	
	@objc func reviewButtonClicked() {
		print("reviewbtnClicked")
	}
	
	@objc func actionButtonClicked(_ sender: UIButton) {
		switch moreViewButton(rawValue: sender.tag)! {
		case .report:
			popupPresent(ReportViewController())
		case .cancle:
			popupPresent(CanclePopupViewController())
		case .review:
			popupPresent(ReviewPopUpViewontroller())
		}
	}
	
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		} else {
			return viewModel.chatList.count
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 1 {
			//MARK: Test
			let row = indexPath.row
			if viewModel.chatList[row].from == viewModel.otherUid.value {
				guard let otherCell = tableView.dequeueReusableCell(withIdentifier: OtherCell.reuseIdentfier, for: indexPath) as? OtherCell else { return UITableViewCell() }
				otherCell.chatLabel.text = viewModel.chatList[row].chat
				otherCell.dateLabel.text = viewModel.chatList[row].createdAt
				otherCell.selectionStyle = .none
				return otherCell
			} else {
				guard let myCell = tableView.dequeueReusableCell(withIdentifier: MyCell.reuseIdentfier, for: indexPath) as? MyCell else { return UITableViewCell() }
				myCell.chatLabel.text = viewModel.chatList[row].chat
				myCell.dateLabel.text = viewModel.chatList[row].createdAt
				myCell.selectionStyle = .none
				return myCell
			}
		} else {
			guard let noticeCell = tableView.dequeueReusableCell(withIdentifier: NoticeCell.reuseIdentfier, for: indexPath) as? NoticeCell else { return UITableViewCell() }
			viewModel.otherNick.bind {
				noticeCell.titleLabel.text = $0+"님과 매칭되었습니다"
			}
			noticeCell.selectionStyle = .none
			return noticeCell
		}
	}


}

extension ChattingViewController: UITextViewDelegate {
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.text == placeholder {
			textView.text = nil
			textView.textColor = .black
		}
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
			textView.text = placeholder
			textView.textColor = .sesacGray7
		}
	}
	
	func textViewDidChange(_ textView: UITextView) {
		let contentHeight = textView.contentSize.height
		print(contentHeight)
		viewModel.validText.value = textView.text.trimmingCharacters(in: ["\n"])
		viewModel.validText.bind {
			self.mainView.sendButton.setImage(UIImage(named: self.viewModel.sendButtonSetting($0.count)), for: .normal)
		}
		DispatchQueue.main.async {
			if contentHeight <= 30 {
				self.mainView.contentView.snp.updateConstraints {
					$0.height.equalTo(24)
				}
			} else if contentHeight >= 80 {
				self.mainView.contentView.snp.updateConstraints {
					$0.height.equalTo(63)
				}
			} else {
				self.mainView.contentView.snp.updateConstraints {
					$0.height.equalTo(contentHeight)
				}
			}
		}
	}
	
}

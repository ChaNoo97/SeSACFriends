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
	let viewModel = ChattingViewModel()
	
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
		moreButtonAddTarget()
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
		mainView.contentView.text = ""
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
			return 10
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 1 {
			guard let otherCell = tableView.dequeueReusableCell(withIdentifier: OtherCell.reuseIdentfier, for: indexPath) as? OtherCell else { return UITableViewCell() }
			
			guard let myCell = tableView.dequeueReusableCell(withIdentifier: MyCell.reuseIdentfier, for: indexPath) as? MyCell else { return UITableViewCell() }

			//MARK: Test
			let row = indexPath.row
			if row == 0 {
				otherCell.chatLabel.text = "아아ㅏ아ㅏ아ㅏㅏ아ㅏ아아아아ㅏ아아ㅏ아아ㅏ아ㅏ아아ㅏ아ㅏ아아ㅏ아아아ㅏ아아ㅏ아아아아아아아ㅏ아ㅏ아ㅏㅏ아ㅏ아아아아ㅏ아아ㅏ아아ㅏ아ㅏ아아ㅏ아ㅏ아아ㅏ아아아ㅏ아아ㅏ아아아아아"
				otherCell.dateLabel.text = "11:11"
				otherCell.selectionStyle = .none
				return otherCell
			} else {
				myCell.chatLabel.text = "우리는 의료 서비스의 정보 불균형 문제를 정보 통신 기술(IT)을 활용하여 해결하고자 노력하고 있고, 그 첫 번째 영역으로 메디컬 뷰티 시장의 정보 비대칭 문제를 해결하고자 합니다."
				myCell.dateLabel.text = "11:11"
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

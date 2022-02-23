//
//  ReviewPopUpViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/23.
//

import UIKit

class ReviewPopUpViewontroller: UIViewController {
	
	let mainView = ReviewPopUpView()
	let viewModel = ReviewPopupViewModel()
	
	let placeholder = "자세한 피드백은 다른 새싹들에게 도움이 됩니다\n(500자 이내 작성)"
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		mainView.contentTextView.text = placeholder
		mainView.contentTextView.textColor = .sesacGray7
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .black.withAlphaComponent(0.5)
		mainView.closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
		mainView.contentTextView.delegate = self
		makeTabGester(view: mainView, target: self, action: #selector(dismissKeyboard))
		collectionViewSetting()
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
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	func collectionViewSetting() {
		mainView.selectionCollectionView.delegate = self
		mainView.selectionCollectionView.dataSource = self
		mainView.selectionCollectionView.register(SelectionCell.self, forCellWithReuseIdentifier: SelectionCell.reuseIdentfier)
	}
	
	@objc func closeButtonClicked() {
		dismiss(animated: true, completion: nil)
	}
	
	@objc func keyboardShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			let keyboardHeight = keyboardSize.height - view.safeAreaInsets.bottom
			let updateHeight = UIScreen.main.bounds.height/2 - keyboardHeight
			mainView.shallView.snp.updateConstraints {
				$0.centerY.equalToSuperview().offset(-updateHeight)
			}
			mainView.shallView.layoutIfNeeded()
		}
	}
	
	@objc func keyboardHide(notification: NSNotification) {
		mainView.shallView.snp.updateConstraints {
			$0.centerY.equalToSuperview()
		}
		mainView.shallView.layoutIfNeeded()
	}

}

extension ReviewPopUpViewontroller: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 6
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectionCell.reuseIdentfier, for: indexPath) as? SelectionCell else { return UICollectionViewCell() }
		let titleArray = ["좋은 매너", "정확한 시간 약속", "빠른 응답", "친절한 성격", "능숙한 취미 실력", "유익한 시간"]
		let row = indexPath.row
		cell.selectButton.setTitle(titleArray[row], for: .normal)
		cell.selectButton.addTarget(self, action: #selector(selectButtonClicked(_:)), for: .touchUpInside)
		cell.selectButton.tag = row
		if viewModel.selectArray[row] {
			cell.contentView.backgroundColor = .sesacGreen
			cell.contentView.layer.borderWidth = 0
			cell.selectButton.setTitleColor(.sesacWhite, for: .normal)
		} else {
			cell.contentView.backgroundColor = .white
			cell.contentView.layer.borderWidth = 1
			cell.selectButton.setTitleColor(.sesacBlack, for: .normal)
		}
		return cell
	}
	
	@objc func selectButtonClicked(_ sender: UIButton) {
		viewModel.selectArray[sender.tag].toggle()
		mainView.selectionCollectionView.reloadData()
	}
	
}

extension ReviewPopUpViewontroller: UITextViewDelegate {
	
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
}

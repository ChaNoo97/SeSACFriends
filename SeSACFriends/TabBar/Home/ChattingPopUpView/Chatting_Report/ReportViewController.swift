//
//  ReportViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/22.
//

import UIKit
import SnapKit

final class ReportViewController: BaseViewController {
	
	let mainView = ReportView()
	let viewModel = ReportViweModel()
	
	let placeholder = "신고 사유를 적어주세요\n허위 신고 시 제재를 받을 수 있습니다"
	
	
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
		collectionViewSetting()
		mainView.contentTextView.delegate = self
		mainView.closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
		makeTabGester(view: mainView, target: self, action: #selector(dismissKeyboard))
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

extension ReportViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 6
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectionCell.reuseIdentfier, for: indexPath) as? SelectionCell else { return UICollectionViewCell() }
		let labelArray = ["불법/사기", "불편한언행", "노쇼", "선정성", "인신공격", "기타"]
		let row = indexPath.row
		cell.selectButton.setTitle(labelArray[row], for: .normal)
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

extension ReportViewController: UITextViewDelegate {
	
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

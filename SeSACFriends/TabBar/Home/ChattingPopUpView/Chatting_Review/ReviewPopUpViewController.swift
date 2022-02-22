//
//  ReviewPopUpViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/23.
//

import UIKit

class ReviewPopUpViewontroller: UIViewController {
	
	let mainView = ReviewPopUpView()
	
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
		collectionViewSetting()
    }
	
	func collectionViewSetting() {
		mainView.selectionCollectionView.delegate = self
		mainView.selectionCollectionView.dataSource = self
		mainView.selectionCollectionView.register(SelectionCell.self, forCellWithReuseIdentifier: SelectionCell.reuseIdentfier)
	}
	
	@objc func closeButtonClicked() {
		dismiss(animated: true, completion: nil)
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
		cell.itemLabel.text = titleArray[row]
		return cell
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

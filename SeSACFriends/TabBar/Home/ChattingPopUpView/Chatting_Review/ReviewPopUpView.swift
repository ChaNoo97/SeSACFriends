//
//  ReviewPopUpView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/23.
//

import UIKit
import SnapKit

final class ReviewPopUpView: UIView, ViewProtocols {
	
	let shallView = UIView()
	let titleLabel = UILabel()
	let subTitleLabel = UILabel()
	let closeButton = UIButton()
	let selectionCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let spacing: CGFloat = 8
		let width = UIScreen.main.bounds.width - (65+spacing)
		layout.minimumLineSpacing = 8
		layout.minimumInteritemSpacing = 8
		layout.scrollDirection = .vertical
		layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		layout.estimatedItemSize = CGSize(width: width/2, height: 32)
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		return cv
	}()
	let contentTextView = UITextView()
	let doButton = MainButton(frame: .zero, type: .disable, text: "리뷰 등록하기")
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	func configure() {
		self.backgroundColor = .black.withAlphaComponent(0.5)
		shallView.backgroundColor = .white
		shallView.layer.cornerRadius = 20
		closeButton.setImage(UIImage(named: "close_big"), for: .normal)
		titleLabel.text = "리뷰등록"
		titleLabel.font = SesacFont.title3M14.font
		subTitleLabel.text = "님과의 취미 활동은 어떠셨나요?"
		subTitleLabel.font = SesacFont.title4R14.font
		subTitleLabel.textColor = .sesacGreen
		contentTextView.backgroundColor = .sesacGray1
		contentTextView.layer.cornerRadius = 8
		contentTextView.font = SesacFont.body3R14.font
	}
	
	func setupConstraint() {
		addSubview(shallView)
		[titleLabel, subTitleLabel, closeButton, selectionCollectionView, contentTextView, doButton].forEach {
			shallView.addSubview($0)
		}
		
		shallView.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.leading.trailing.equalToSuperview().inset(16)
		}
		
		titleLabel.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.top.equalToSuperview().inset(17)
			$0.height.equalTo(22)
		}
		
		subTitleLabel.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.top.equalTo(titleLabel.snp.bottom).offset(17)
			$0.height.equalTo(22)
		}
		
		closeButton.snp.makeConstraints {
			$0.trailing.top.equalToSuperview().inset(16)
			$0.size.equalTo(24)
		}
		
		selectionCollectionView.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(16)
			$0.top.equalTo(subTitleLabel.snp.bottom).offset(24)
			$0.height.equalTo(112)
		}
		
		contentTextView.snp.makeConstraints {
			$0.top.equalTo(selectionCollectionView.snp.bottom).offset(24)
			$0.leading.trailing.equalToSuperview().inset(16)
			$0.height.equalTo(124)
		}
		
		doButton.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(16)
			$0.top.equalTo(contentTextView.snp.bottom).offset(24)
			$0.height.equalTo(48)
			$0.bottom.equalToSuperview().inset(16)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	
}

//
//  ReviewView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/30.
//

import UIKit
import SnapKit

class ReviewView: UIView, ViewProtocols {
	
	let title = UILabel()
	let reviewLabel = UILabel()
	let moreButton = UIButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	func configure() {
		title.text = "새싹 리뷰"
		title.font = SesacFont.title6R12.font
		moreButton.setImage(UIImage(named: "moreArrow"), for: .normal)
		reviewLabel.numberOfLines = 0
		reviewLabel.font = SesacFont.body3R14.font
		reviewLabel.text = "첫 리뷰를 기다리는 중이에요!"
		reviewLabel.textColor = .sesacGray6
	}
	
	func setupConstraint() {
		[title, moreButton, reviewLabel].forEach {
			addSubview($0)
		}
		
		title.snp.makeConstraints {
			$0.top.equalTo(self).offset(24)
			$0.leading.equalTo(self).inset(16)
			$0.height.equalTo(18)
		}
		
		moreButton.snp.makeConstraints {
			$0.centerY.equalTo(title)
			$0.trailing.equalTo(self).inset(21)
			$0.size.equalTo(16)
		}
		
		reviewLabel.snp.makeConstraints {
			$0.top.equalTo(title.snp.bottom).offset(16)
			$0.leading.trailing.equalTo(self).inset(16)
			$0.bottom.equalTo(self).inset(16)
		}
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
}

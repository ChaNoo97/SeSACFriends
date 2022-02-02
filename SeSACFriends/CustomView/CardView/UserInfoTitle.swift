//
//  UserInfoTitle.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/02.
//

import UIKit

class UserInfoTitle: UIView, ViewProtocols {
	
	let nameLabel = UILabel()
	let	arrowButton = UIButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	func configure() {
		nameLabel.font = SesacFont.title1M16.font
		//test
		nameLabel.text = "김새싹"
		arrowButton.setImage(UIImage(named: "downArrow"), for: .normal)
	}
	
	func setupConstraint() {
		[nameLabel, arrowButton].forEach {
			addSubview($0)
		}
		
		nameLabel.snp.makeConstraints {
			$0.leading.equalTo(self).inset(16)
			$0.centerY.equalTo(self)
			$0.height.equalTo(26)
		}
		
		arrowButton.snp.makeConstraints {
			$0.centerY.equalTo(self)
			$0.trailing.equalTo(self).inset(16)
			$0.size.equalTo(16)
		}
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

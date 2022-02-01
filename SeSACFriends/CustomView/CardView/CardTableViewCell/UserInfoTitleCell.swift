//
//  UserInfoTitleCell.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/01.
//

import UIKit
import SnapKit

class UserInfoTitleCell: UITableViewCell {
	let nameLabel = UILabel()
	let	arrowImageView = UIImageView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
		setupConstraint()
	}
	
	func configure() {
		nameLabel.font = SesacFont.title1M16.font
		//test
		nameLabel.text = "김새싹"
	}
	
	func setupConstraint() {
		[nameLabel, arrowImageView].forEach {
			contentView.addSubview($0)
		}
		
		nameLabel.snp.makeConstraints {
			$0.leading.equalTo(self).inset(16)
			$0.centerY.equalTo(self)
			$0.height.equalTo(26)
		}
		
		arrowImageView.snp.makeConstraints {
			$0.centerY.equalTo(self)
			$0.trailing.equalTo(self).inset(16)
			$0.size.equalTo(16)
		}
		
	}
	
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

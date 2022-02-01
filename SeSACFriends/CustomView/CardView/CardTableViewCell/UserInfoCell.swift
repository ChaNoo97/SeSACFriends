//
//  UserInfoCell.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/31.
//

import UIKit
import SnapKit

class UserInfoCell: UITableViewCell {
	
	let reputationView = ReputationView()
	let reviewView = ReviewView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraint()
	}
	
	func setupConstraint() {
		[reputationView, reviewView].forEach{
			contentView.addSubview($0)
		}
		
		reputationView.snp.makeConstraints {
			$0.top.equalTo(self)
			$0.leading.trailing.equalTo(self).inset(16)
			$0.height.equalTo(146)
		}
		
		reviewView.snp.makeConstraints {
			$0.top.equalTo(reputationView.snp.bottom).offset(24)
			$0.leading.trailing.equalTo(self).inset(16)
			$0.height.greaterThanOrEqualTo(58)
//			$0.bottom.equalToSuperview()
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

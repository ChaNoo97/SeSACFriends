//
//  My.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/22.
//

import UIKit
import SnapKit
 
final class MyCell: OtherCell {
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
		setupConstraint()
	}
	
	
	override func configure() {
		super.configure()
		chatView.backgroundColor = .sesacWhitegreen
		chatView.layer.borderWidth = 0
	}
	
	override func setupConstraint() {
		
		[chatView, dateLabel].forEach {
			contentView.addSubview($0)
		}
		chatView.addSubview(chatLabel)
		
		chatView.snp.makeConstraints {
			$0.trailing.equalToSuperview().inset(16)
			$0.top.bottom.equalToSuperview().inset(12)
			$0.leading.greaterThanOrEqualToSuperview().inset(95)
		}
		
		dateLabel.snp.makeConstraints {
			$0.trailing.equalTo(chatView.snp.leading).offset(-8)
			$0.bottom.equalTo(chatView.snp.bottom)
			$0.height.equalTo(18)
		}
		
		chatLabel.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(16)
			$0.top.bottom.equalToSuperview().inset(10)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

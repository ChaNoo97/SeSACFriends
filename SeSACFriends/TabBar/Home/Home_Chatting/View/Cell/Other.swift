//
//  File.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/22.
//

import UIKit
import SnapKit

class OtherCell: UITableViewCell, ViewProtocols {
	
	let chatView = UIView()
	let dateLabel = UILabel()
	let chatLabel = UILabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
		setupConstraint()
	}
	
	func configure() {
		chatView.layer.cornerRadius = 8
		chatView.layer.borderColor = UIColor.sesacGray4.cgColor
		chatView.layer.borderWidth = 1
		chatLabel.font = SesacFont.body3R14.font
		dateLabel.font = SesacFont.title6R12.font
		dateLabel.textColor = .sesacGray6
		chatLabel.numberOfLines = 0
	}
	
	func setupConstraint() {
		[chatView, dateLabel].forEach {
			contentView.addSubview($0)
		}
		chatView.addSubview(chatLabel)
		
		chatView.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(16)
			$0.trailing.lessThanOrEqualToSuperview().inset(95)
			$0.top.bottom.equalToSuperview().inset(12)
		}
		
		dateLabel.snp.makeConstraints {
			$0.leading.equalTo(chatView.snp.trailing).offset(8)
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

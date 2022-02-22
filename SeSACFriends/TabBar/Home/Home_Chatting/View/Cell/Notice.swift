//
//  Notice.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/22.
//

import UIKit
import SnapKit

final class NoticeCell: UITableViewCell, ViewProtocols {
	
	let titleView = UIView()
	let bellImage = UIImageView()
	let titleLabel = UILabel()
	let subTitleLabel = UILabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
		setupConstraint()
	}
	
	func configure() {
		bellImage.image = UIImage(named: "bell")
		titleLabel.font = SesacFont.title3M14.font
		titleLabel.textColor = .sesacGray7
		subTitleLabel.font = SesacFont.title4R14.font
		subTitleLabel.textColor = .sesacGray6
		subTitleLabel.text = "채팅을 통해 약속을 정해보세요 :)"
	}
	
	func setupConstraint() {
		[titleView, subTitleLabel].forEach {
			contentView.addSubview($0)
		}
		
		[titleLabel, bellImage].forEach {
			titleView.addSubview($0)
		}
		
		titleView.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.top.equalToSuperview().inset(12)
			$0.width.equalTo(178)
			$0.height.equalTo(22)
		}
		
		bellImage.snp.makeConstraints {
			$0.leading.equalToSuperview()
			$0.centerY.equalToSuperview()
			$0.size.equalTo(16)
		}
		
		titleLabel.snp.makeConstraints {
			$0.leading.equalTo(bellImage.snp.trailing).offset(4)
			$0.top.bottom.equalToSuperview()
			$0.trailing.equalToSuperview()
		}
		
		subTitleLabel.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.top.equalTo(titleView.snp.bottom).offset(2)
			$0.height.equalTo(22)
			$0.bottom.equalToSuperview().inset(12)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

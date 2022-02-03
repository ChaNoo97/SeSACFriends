//
//  AppInfoCell.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/28.
//

import UIKit
import SnapKit

final class AppInfoCell: UITableViewCell, ViewProtocols {
	
	let iconImage = UIImageView()
	let titleLabel = UILabel()
	let designLine = UIView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
		setupConstraint()
	}
	
	func configure() {
		titleLabel.font = SesacFont.title2R16.font
		designLine.backgroundColor = .sesacGray2
	}
	
	func setupConstraint() {
		[iconImage, titleLabel, designLine].forEach {
			contentView.addSubview($0)
		}
		
		iconImage.snp.makeConstraints {
			$0.centerY.equalTo(self)
			$0.size.equalTo(24)
			$0.leading.equalTo(self).inset(17)
		}
		
		titleLabel.snp.makeConstraints {
			$0.centerY.equalTo(self)
			$0.width.equalTo(100)
			$0.leading.equalTo(iconImage.snp.trailing).offset(12)
		}
		
		designLine.snp.makeConstraints {
			$0.bottom.equalTo(self)
			$0.height.equalTo(1)
			$0.leading.equalTo(self).inset(17)
			$0.trailing.equalTo(self).inset(15)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
}

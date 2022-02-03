//
//  MyInfoCell.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/28.
//

import UIKit
import SnapKit

final class MyInfoCell: UITableViewCell, ViewProtocols {
	
	let profileImage = UIImageView()
	let profileName = UILabel()
	let moreImage = UIImageView()
	let designLine = UIView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
		setupConstraint()
	}
	
	
	func configure() {
		profileImage.image = UIImage(named: "profileImg")
		moreImage.image = UIImage(named: "moreArrow")
		profileName.font = SesacFont.display1R20.font
		designLine.backgroundColor = .sesacGray2
	}
	
	func setupConstraint() {
		[profileImage, profileName, moreImage, designLine].forEach {
			contentView.addSubview($0)
		}
		
		profileImage.snp.makeConstraints {
			$0.size.equalTo(50)
			$0.centerY.equalTo(self)
			$0.leading.equalTo(self).inset(15)
		}
		
		profileName.snp.makeConstraints {
			$0.centerY.equalTo(self)
			$0.leading.equalTo(profileImage.snp.trailing).offset(13)
			$0.height.equalTo(26)
			$0.width.equalTo(100)
		}
		
		moreImage.snp.makeConstraints {
			$0.centerY.equalTo(self)
			$0.trailing.equalTo(self).inset(22)
			$0.height.equalTo(18)
			$0.width.equalTo(9)
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

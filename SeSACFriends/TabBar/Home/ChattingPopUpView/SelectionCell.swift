//
//  SelectionCell.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/22.
//

import UIKit
import SnapKit

final class SelectionCell: UICollectionViewCell {
	
	let selectButton = UIButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setUpConstraints()
		
	}
	
	func configure() {
		contentView.layer.cornerRadius = 8
		contentView.layer.borderColor = UIColor.sesacGray4.cgColor
		contentView.layer.borderWidth = 1
		selectButton.titleLabel?.font = SesacFont.title4R14.font
		selectButton.setTitleColor(.black, for: .normal)
	}
	
	func setUpConstraints() {
		contentView.addSubview(selectButton)
		
		selectButton.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.height.equalTo(22)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

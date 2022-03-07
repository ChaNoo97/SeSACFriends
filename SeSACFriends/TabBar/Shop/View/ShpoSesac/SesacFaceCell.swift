//
//  SesacFaceCell.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/03/07.
//

import UIKit
import SnapKit

final class SesacFaceCell: UICollectionViewCell, ViewProtocols {
	
	let imageViwe = UIImageView()
	let titleLable = UILabel()
	let subTitleLabel = UILabel()
	let purchaseButton = PurchaseButton(frame: .zero, type: .noPurchase, title: "보유")
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	
	func configure() {
		imageViwe.layer.borderColor = UIColor.sesacGray2.cgColor
		imageViwe.layer.borderWidth = 1
		imageViwe.layer.cornerRadius = 8
		titleLable.font = SesacFont.title2R16.font
		subTitleLabel.font = SesacFont.body3R14.font
		subTitleLabel.numberOfLines = 0
	}
	
	func setupConstraint() {
		[imageViwe, titleLable, subTitleLabel, purchaseButton].forEach {
			contentView.addSubview($0)
		}
		
		imageViwe.snp.makeConstraints {
			$0.top.equalToSuperview()
			$0.leading.trailing.equalToSuperview()
			$0.height.equalTo(imageViwe.snp.width)
		}
		
		titleLable.snp.makeConstraints {
			$0.leading.equalToSuperview()
			$0.top.equalTo(imageViwe.snp.bottom).offset(8)
			$0.height.equalTo(26)
		}
		
		subTitleLabel.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview()
			$0.top.equalTo(titleLable.snp.bottom).offset(8)
//			$0.bottom.equalToSuperview()
		}
		purchaseButton.snp.makeConstraints {
			$0.centerY.equalTo(titleLable)
			$0.trailing.equalToSuperview().inset(9)
			$0.width.equalTo(52)
			$0.height.equalTo(20)
		}
		
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

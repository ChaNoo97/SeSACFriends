//
//  BackgroundCell.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/03/07.
//

import UIKit
import SnapKit



final class BackgroundCell: UITableViewCell, ViewProtocols {
	
	let shallView = UIView()
	let imageViwe = UIImageView()
	let titleLable = UILabel()
	let subTitleLabel = UILabel()
	let purchaseButton = PurchaseButton(frame: .zero, type: .noPurchase, title: "1,200")
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
		setupConstraint()
	}
	
	
	func configure() {
		imageViwe.layer.cornerRadius = 8
		imageViwe.clipsToBounds = true
		subTitleLabel.numberOfLines = 0
		titleLable.font = SesacFont.title3M14.font
		subTitleLabel.font = SesacFont.body3R14.font
	}
	
	func setupConstraint() {
		contentView.addSubview(shallView)
		[imageViwe, titleLable, subTitleLabel, purchaseButton].forEach {
			shallView.addSubview($0)
		}
		
		shallView.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(16)
			$0.top.bottom.equalToSuperview()
		}
		
		imageViwe.snp.makeConstraints {
			$0.leading.equalToSuperview()
			$0.top.bottom.equalToSuperview().inset(8)
			$0.size.equalTo(165)
		}
		
		titleLable.snp.makeConstraints {
			$0.leading.equalTo(imageViwe.snp.trailing).offset(12)
			$0.top.equalToSuperview().offset(43)
			$0.height.equalTo(22)
		}
		
		subTitleLabel.snp.makeConstraints {
			$0.leading.equalTo(titleLable.snp.leading)
			$0.trailing.equalToSuperview()
			$0.top.equalTo(titleLable.snp.bottom).offset(8)
			$0.height.equalTo(48)
		}
		
		purchaseButton.snp.makeConstraints {
			$0.top.equalTo(titleLable.snp.top)
			$0.trailing.equalToSuperview()
			$0.height.equalTo(20)
			$0.width.equalTo(52)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

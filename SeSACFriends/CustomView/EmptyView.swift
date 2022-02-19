//
//  EmptyView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/18.
//

import UIKit
import SnapKit

final class EmptyView: UIView, ViewProtocols {
	
	let imageView = UIImageView()
	let titleLable = UILabel()
	let subTitleLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	func configure() {
		imageView.image = UIImage(named: "emptySesac")
		titleLable.font = SesacFont.display1R20.font
		titleLable.text = "아쉽게도 주변에 새싹이 없어요ㅠ"
		subTitleLabel.font = SesacFont.title4R14.font
		subTitleLabel.text = "취미를 변경하거나 조금만 더 기다려 주세요!"
		subTitleLabel.textColor = .sesacGray7
	}
	
	func setupConstraint() {
		[imageView, titleLable, subTitleLabel].forEach {
			addSubview($0)
		}
		imageView.snp.makeConstraints {
			$0.top.equalToSuperview().inset(4)
			$0.centerX.equalTo(self)
			$0.size.equalTo(64)
		}
		
		titleLable.snp.makeConstraints {
			$0.centerX.equalTo(self)
			$0.height.equalTo(32)
			$0.top.equalTo(imageView.snp.bottom).offset(32)
		}
		
		subTitleLabel.snp.makeConstraints {
			$0.centerX.equalTo(self)
			$0.height.equalTo(22)
			$0.top.equalTo(titleLable.snp.bottom).offset(8)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

//
//  PopUpView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/06.
//

import UIKit
import SnapKit

class PopUpView: UIView, ViewProtocols {
	
	let alertView = UIView()
	let titleLabel = UILabel()
	let subTitleLabel = UILabel()
	let cancelButton = UIButton()
	let allowButton = UIButton()
	let stackView = UIStackView()
	let title: String
	let subTitle: String
	let cancelTitleLabel = UILabel()
	let allowTitleLabel = UILabel()
	let cancelTitle: String
	let allowTitle: String
	
	init(frame: CGRect, title: String, subTitle: String, cnacelTitle: String, allowTitle: String) {
		self.title = title
		self.subTitle = subTitle
		self.cancelTitle = cnacelTitle
		self.allowTitle = allowTitle
		super.init(frame: frame)
		stackViewConfigure()
		configure()
		setupConstraint()
	}
	
	func stackViewConfigure() {
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.spacing = 8
	}
	
	func configure() {
		self.backgroundColor = .black.withAlphaComponent(0.5)
		self.isOpaque = false
		alertView.backgroundColor = .white
		alertView.layer.cornerRadius = 16
		[allowButton, cancelButton].forEach {
			$0.layer.cornerRadius = 8
		}
		setupLabel(label: titleLabel, font: .body1M16, text: title)
		setupLabel(label: subTitleLabel, font: .title4R14, text: subTitle)
		setupLabel(label: allowTitleLabel, font: .body3R14, text: allowTitle)
		setupLabel(label: cancelTitleLabel, font: .body3R14, text: cancelTitle)
		allowTitleLabel.textColor = .sesacWhite
		cancelTitleLabel.textColor = .sesacBlack
		titleLabel.textColor = .black
		subTitleLabel.textColor = .sesacGray7
		cancelButton.backgroundColor = .sesacGray2
		allowButton.backgroundColor = .green
	}
	
	func setupConstraint() {
		addSubview(alertView)
		[titleLabel, subTitleLabel,stackView].forEach {
			alertView.addSubview($0)
		}
		[cancelButton,allowButton].forEach {
			stackView.addArrangedSubview($0)
		}
		cancelButton.addSubview(cancelTitleLabel)
		allowButton.addSubview(allowTitleLabel)
		
		alertView.snp.makeConstraints {
			$0.centerY.equalTo(self)
			$0.leading.trailing.equalTo(self).inset(16)
			$0.height.equalTo(156)
		}
		
		titleLabel.snp.makeConstraints {
			$0.leading.trailing.equalTo(alertView).inset(16.5)
			$0.top.equalTo(alertView).inset(16)
			$0.height.equalTo(30)
		}
		
		subTitleLabel.snp.makeConstraints {
			$0.leading.trailing.equalTo(titleLabel)
			$0.top.equalTo(titleLabel.snp.bottom).offset(8)
			$0.height.equalTo(22)
		}
		
		stackView.snp.makeConstraints {
			$0.leading.trailing.equalTo(alertView).inset(16)
			$0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
			$0.bottom.equalTo(alertView).inset(16)
		}
		
		cancelTitleLabel.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(16)
			$0.top.bottom.equalToSuperview().inset(12)
		}
		
		allowTitleLabel.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(16)
			$0.top.bottom.equalToSuperview().inset(12)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

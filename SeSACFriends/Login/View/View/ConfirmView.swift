//
//  ConfirmView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/21.
//

import UIKit
import SnapKit

final class ConfirmView: LoginBaseView, ViewProtocols {
	
	let titleLabel = UILabel()
	let subTitleLabel = UILabel()
	let timerLabel = UILabel()
	let authTextField = MainTextField(frame: .zero, type: .inactive)
	let repeatButton = MainButton(frame: .zero, type: .disable, text: LoginButtonText.again.rawValue)
	
	init() {
		super.init(frame: .zero, textType: .start)
		self.configure()
		self.setupConstraint()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure() {
		authTextField.textField.placeholder = "인증번호 입력"
		setupLabel(label: titleLabel, font: .display1R20, text: "인증번호가 문자로 전송되었어요")
		setupLabel(label: subTitleLabel, font: .title2R16, text: "(최대 소모 20초)")
		subTitleLabel.textColor = .sesacGray7
		setupLabel(label: timerLabel, font: .title3M14, text: "01:00")
		timerLabel.textColor = .sesacGreen
	}
	
	override func setupConstraint() {
		super.setupConstraint()
		
		[titleLabel, subTitleLabel, authTextField, repeatButton].forEach {
			addSubview($0)
		}
		
		authTextField.addSubview(timerLabel)

		repeatButton.snp.makeConstraints {
			$0.trailing.equalToSuperview().inset(16)
			$0.bottom.equalTo(mainButton.snp.top).offset(-74)
			$0.height.equalTo(40)
			$0.width.equalTo(72)
		}

		authTextField.snp.makeConstraints {
			$0.leading.equalToSuperview().offset(16)
			$0.bottom.equalTo(mainButton.snp.top).offset(-72)
			$0.trailing.equalTo(repeatButton.snp.leading).offset(-8)
			$0.height.equalTo(48)
		}

		timerLabel.snp.makeConstraints {
			$0.trailing.equalTo(authTextField.snp.trailing).inset(12)
			$0.top.bottom.equalTo(authTextField).inset(13)
			$0.width.equalTo(37)
		}
		
		subTitleLabel.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.height.equalTo(26)
			$0.bottom.equalTo(authTextField.snp.top).offset(-63)
		}
		
		titleLabel.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.height.equalTo(32)
			$0.bottom.equalTo(subTitleLabel.snp.top).offset(-8)
		}

	}
	
	
}

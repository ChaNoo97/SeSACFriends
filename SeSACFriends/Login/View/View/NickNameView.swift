//
//  NickNameView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/22.
//

import UIKit
import SnapKit

final class NickNameVeiw: LoginBaseView, ViewProtocols {
	
	let nickNameTextField = MainTextField(frame: .zero, type: .inactive)
	let titleLabel = UILabel()
	
	init() {
		super.init(frame: .zero, textType: .next)
		self.configure()
		self.setupConstraint()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure() {
		nickNameTextField.textField.placeholder = "10자 이내로 입력"
		setupLabel(label: titleLabel, font: .display1R20, text: "닉네임을 입력해 주세요")
	}
	
	override func setupConstraint() {
		super.setupConstraint()
		[nickNameTextField, titleLabel].forEach {
			addSubview($0)
		}
		
		nickNameTextField.snp.makeConstraints {
			$0.bottom.equalTo(mainButton.snp.top).offset(-72)
			$0.leading.trailing.equalToSuperview().inset(16)
			$0.height.equalTo(48)
		}
		
		titleLabel.snp.makeConstraints {
			$0.bottom.equalTo(nickNameTextField.snp.top).offset(-80)
			$0.centerX.equalToSuperview()
			$0.height.equalTo(32)
		}
	}
	
}

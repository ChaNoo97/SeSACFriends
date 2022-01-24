//
//  emailView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/23.
//

import UIKit
import SnapKit

public class emailView: LoginBaseView, ViewProtocols {
	
	let titleLabel = UILabel()
	let subTitleLabel = UILabel()
	let emailTextField = MainTextField(frame: .zero, type: .inactive)
	
	init() {
		super.init(frame: .zero, textType: .next)
		configure()
		setupConstraint()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func configure() {
		setupLabel(label: titleLabel, font: .display1R20, text: "이메일을 입력해 주세요")
		setupLabel(label: subTitleLabel, font: .title2R16, text: "휴대폰 번호 변경 시 인증을 위해 사용해요")
		subTitleLabel.textColor = .sesacGray7
		emailTextField.textField.placeholder = "SeSAC@email.com"
	}
	
	public override func setupConstraint() {
		super.setupConstraint()
		
		[titleLabel, subTitleLabel, emailTextField].forEach {
			addSubview($0)
		}
		
		emailTextField.snp.makeConstraints {
			$0.bottom.equalTo(button.snp.top).offset(-72)
			$0.leading.trailing.equalToSuperview().offset(16)
			$0.height.equalTo(48)
		}
		
		subTitleLabel.snp.makeConstraints {
			$0.bottom.equalTo(emailTextField.snp.top).offset(-63)
			$0.centerX.equalToSuperview()
			$0.height.equalTo(26)
		}
		
		titleLabel.snp.makeConstraints {
			$0.bottom.equalTo(subTitleLabel.snp.top).offset(-8)
			$0.centerX.equalToSuperview()
			$0.height.equalTo(32)
		}
		
	}
	
	
}

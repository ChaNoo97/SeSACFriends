//
//  LoginView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/21.
//

import UIKit
import SnapKit

public class LoginView: LoginBaseView, ViewProtocols {
	
	
	let label = UILabel()
	let textfield = MainTextField(frame: .zero, type: .inactive)
	
	init() {
		super.init(frame: .zero, textType: .receive)
		self.setupConstraint()
		self.configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func configure() {
		label.numberOfLines = 0
		label.font = SesacFont.display1R20.font
		label.textAlignment = .center
		label.text = """
			새싹 서비스 이용을 위해
			휴대폰 번호를 입력해 주세요
			"""
	}
	
	public override func setupConstraint() {
		super.setupConstraint()
		
		[textfield, label].forEach {
			addSubview($0)
		}
		
		textfield.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.bottom.equalTo(button.snp.top).offset(-72)
			$0.leading.trailing.equalToSuperview().inset(16)
			$0.height.equalTo(48)
		}
		
		label.snp.makeConstraints {
			$0.bottom.equalTo(textfield.snp.top).offset(-64)
			$0.centerX.equalToSuperview()
			$0.leading.trailing.equalToSuperview().inset(73)
			$0.height.equalTo(64)
		}
	}
}

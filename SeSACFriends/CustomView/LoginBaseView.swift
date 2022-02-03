//
//  LoginBaseView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/21.
//

import UIKit
import SnapKit


enum LoginButtonText: String {
	case receive = "인증 문자 받기"
	case start = "인증하고 시작하기"
	case next = "다음"
	case again = "재전송"
}

class LoginBaseView: UIView {
	var textType: LoginButtonText
	var mainButton = MainButton(frame: .zero, type: .disable, text: "")
	
	init(frame: CGRect, textType: LoginButtonText) {
		self.textType = textType
		self.mainButton = MainButton(frame: .zero, type: .disable, text: textType.rawValue)
		super.init(frame: frame)
		setupConstraint()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupConstraint() {
//		print("LoginBaseView", #function)
		addSubview(mainButton)
		mainButton.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.leading.trailing.equalToSuperview().inset(16)
			$0.height.equalTo(48)
		}
	}
	
}

extension UIView {
	func setupLabel(label: UILabel, font: SesacFont, text: String) {
		label.numberOfLines = 0
		label.textAlignment = .center
		label.font = font.font
		label.text = text
	}
}

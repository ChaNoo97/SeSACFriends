//
//  LoginBaseView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/21.
//

import UIKit
import SnapKit


public enum LoginButtonText: String {
	case receive = "인증 문자 받기"
	case start = "인증하고 시작하기"
	case next = "다음"
}

public class LoginBaseView: UIView {
	var textType: LoginButtonText
	var button = MainButton(frame: .zero, type: .disable, text: "")
	
	init(frame: CGRect, textType: LoginButtonText) {
		self.textType = textType
		self.button = MainButton(frame: .zero, type: .disable, text: textType.rawValue)
		super.init(frame: frame)
		setupConstraint()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func setupConstraint() {
		addSubview(button)
		button.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.leading.trailing.equalToSuperview().inset(16)
			$0.height.equalTo(48)
		}
	}
	
}

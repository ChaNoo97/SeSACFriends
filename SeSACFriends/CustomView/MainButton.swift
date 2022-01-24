//
//  MainButton.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/20.
//

import UIKit

public enum MainButtonType {
	case inactive
	case fill
	case outline
	case cancel
	case disable
}

class MainButton: UIButton {
	
	var type: MainButtonType
	var text: String
	
	init(frame: CGRect, type: MainButtonType, text: String) {
		self.type = type
		self.text = text
		super.init(frame: frame)
		setupButton(text: text)
		setupButtonType(type: type)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupButton(text: String) {
		clipsToBounds = true
		layer.cornerRadius = 8
		
		setTitle(text, for: .normal)
		titleLabel?.font = SesacFont.body3R14.font
	}
	
	func setupButtonType(type: MainButtonType) {
		self.type = type
		
		switch self.type {
		case .inactive:
			backgroundColor = .sesacWhite
			layer.borderWidth = 1
			layer.borderColor = UIColor.sesacGray4.cgColor
			setTitleColor(.sesacBlack, for: .normal)
		case .fill:
			backgroundColor = .sesacGreen
			setTitleColor(.sesacWhite, for: .normal)
		case .outline:
			backgroundColor = .sesacWhite
			layer.borderColor = UIColor.sesacGreen.cgColor
			layer.borderWidth = 1
			setTitleColor(.sesacGreen, for: .normal)
		case .cancel:
			backgroundColor = .sesacGray2
			setTitleColor(.sesacBlack, for: .normal)
		case .disable:
			backgroundColor = .sesacGray6
			setTitleColor(.sesacGray3, for: .normal)
		}
	}
	
}

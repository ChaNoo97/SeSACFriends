//
//  GenderButton.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/24.
//

import UIKit

public enum GenderButtonType {
	case select
	case unSelect
}

class GenderButton: UIButton {
	
	var type: GenderButtonType
	
	init(frame: CGRect, type: GenderButtonType) {
		self.type = type
		super.init(frame: frame)
		setupButton()
		setupButtonType(type: type)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupButton() {
		clipsToBounds = true
		layer.cornerRadius = 8
		titleLabel?.font = SesacFont.title2R16.font
	}
	
	func setupButtonType(type: GenderButtonType) {
		self.type = type
		
		switch self.type {
		case .select:
			backgroundColor = .sesacWhitegreen
			layer.borderWidth = 0
		case .unSelect:
			backgroundColor = .sesacWhite
			layer.borderWidth = 1
			layer.borderColor = UIColor.sesacGray3.cgColor
		}
	}
}

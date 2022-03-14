//
//  PurchaseButton.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/03/07.
//

import UIKit

enum PurchaseButtonStyle {
	case purchase
	case noPurchase
}

final class PurchaseButton: UIButton {
	
	var type: PurchaseButtonStyle
	var title: String
	
	init(frame: CGRect, type: PurchaseButtonStyle, title: String) {
		self.type = type
		self.title = title
		super.init(frame: frame)
		setUpButton(title: title)
		setUpButtonType(type: type)
	}
	
	func setUpButton(title: String) {
		clipsToBounds = true
		layer.cornerRadius = 10
		
		setTitle(title, for: .normal)
		titleLabel?.font = SesacFont.title5M12.font
	}
	
	func setUpButtonType(type: PurchaseButtonStyle) {
		self.type = type
		
		switch self.type {
		case .purchase:
			backgroundColor = .sesacGray2
			setTitleColor(.sesacGray7, for: .normal)
			setTitle("보유", for: .normal)
		case .noPurchase:
			backgroundColor = .sesacGreen
			setTitleColor(.sesacWhite, for: .normal)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

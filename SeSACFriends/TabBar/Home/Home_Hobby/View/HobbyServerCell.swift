//
//  HobbyServerCell.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/12.
//

import UIKit
import SnapKit

enum serverCellType {
	case recommend
	case otherUser
	case none
}

class HobbyServerCell: UICollectionViewCell {
	
	let shallView = UIView()
	let textLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	
	func configure() {
		shallView.layer.cornerRadius = 8
		shallView.layer.borderWidth = 1
		textLabel.font = SesacFont.title4R14.font
		
	}
	
	func setupConstraint() {
		addSubview(shallView)
		shallView.addSubview(textLabel)
		
		shallView.snp.makeConstraints {
			$0.height.equalTo(32)
		}
		
		textLabel.snp.makeConstraints {
			$0.top.bottom.equalTo(shallView).inset(5)
			$0.leading.trailing.equalTo(shallView).inset(16)
		}
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}


/*
 switch type {
 case .recommend:
	 shallView.layer.borderColor = UIColor.sesacError.cgColor
	 textLabel.textColor = .sesacError
 case .otherUser:
	 shallView.layer.borderColor = UIColor.sesacGray4.cgColor
	 textLabel.textColor = .sesacBlack
 case .none:
	 shallView.layer.borderColor = UIColor.sesacGreen.cgColor
	 textLabel.textColor = .sesacGreen
 }switch type {
 case .recommend:
		   shallView.layer.borderColor = UIColor.sesacError.cgColor
		   textLabel.textColor = .sesacError
	   case .otherUser:
		   shallView.layer.borderColor = UIColor.sesacGray4.cgColor
		   textLabel.textColor = .sesacBlack
	   case .none:
		   shallView.layer.borderColor = UIColor.sesacGreen.cgColor
		   textLabel.textColor = .sesacGreen
	   }
 */

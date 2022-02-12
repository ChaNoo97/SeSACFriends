//
//  HobbyClientCell.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/12.
//

import UIKit
import SnapKit

final class HobbyClientCell: HobbyServerCell {
	
	let closeButton = UIButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	
	override func configure() {
		super.configure()
		shallView.layer.borderColor = UIColor.sesacGreen.cgColor
		closeButton.setImage(UIImage(named: "close"), for: .normal)
		textLabel.textColor = .sesacGreen
	}
	
	override func setupConstraint() {
		addSubview(shallView)
		[textLabel, closeButton].forEach {
			shallView.addSubview($0)
		}
		
		shallView.snp.makeConstraints {
			$0.height.equalTo(32)
		}
		
		textLabel.snp.makeConstraints {
			$0.top.bottom.equalTo(shallView).inset(5)
			$0.leading.equalTo(shallView).inset(16)
		}
		
		closeButton.snp.makeConstraints {
			$0.leading.equalTo(textLabel.snp.trailing).offset(4)
			$0.trailing.equalTo(shallView.snp.trailing).inset(16)
			$0.centerY.equalTo(textLabel)
			$0.size.equalTo(16)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

//
//  BirthSubView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/23.
//

import UIKit
import SnapKit

public class BirthSubView: UIView, ViewProtocols {
	let textField = MainTextField(frame: .zero, type: .inactive)
	let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func configure() {
		label.font = SesacFont.title2R16.font
		textField.textField.font = SesacFont.title4R14.font
		textField.textField.textColor = .sesacGray7
	}
	
	public func setupConstraint() {
		[textField, label].forEach {
			addSubview($0)
		}
		
		textField.snp.makeConstraints {
			$0.top.leading.bottom.equalToSuperview()
			$0.width.equalTo(80)
		}
		
		label.snp.makeConstraints {
			$0.leading.equalTo(textField.snp.trailing).offset(4)
			$0.trailing.equalToSuperview()
			$0.height.equalTo(26)
			$0.centerY.equalToSuperview()
		}
		
	}
	
	
}

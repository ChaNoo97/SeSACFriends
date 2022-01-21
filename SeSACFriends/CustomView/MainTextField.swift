//
//  MainTextField.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/21.
//

import UIKit
import SnapKit

public enum TextFieldType {
	case inactive
	case focus
	case active
	case disable
	case error
	case success
}

public class MainTextField: UIView, ViewProtocols {
	
	let contentView = UIView()
	let textField = UITextField()
	let designLine = UIView()
	let notiLabel = UILabel()
	var type: TextFieldType
	
	init(frame: CGRect, type: TextFieldType) {
		
		self.type = type
		super.init(frame: frame)
		configure()
		setupConstraint()
		setupType(type: type)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func configure() {
		contentView.layer.cornerRadius = 4
		textField.clipsToBounds = true
		textField.backgroundColor = .clear
		textField.font = SesacFont.title4R14.font
		textField.layer.borderWidth = 0
		notiLabel.isHidden = true
		notiLabel.font = SesacFont.body4R12.font
	}
	
	public func setupConstraint() {
		
		[contentView, notiLabel].forEach {
			addSubview($0)
		}
		
		[designLine, textField].forEach {
			contentView.addSubview($0)
		}
		
		contentView.snp.makeConstraints {
			$0.top.leading.trailing.equalToSuperview()
			$0.height.equalTo(48)
		}
		
		textField.snp.makeConstraints {
			$0.top.bottom.equalTo(contentView).inset(13)
			$0.leading.equalTo(contentView.snp.leading).inset(12)
			$0.trailing.greaterThanOrEqualTo(contentView.snp.trailing).inset(12)
		}
		
		designLine.snp.makeConstraints {
			$0.height.equalTo(1)
			$0.bottom.equalTo(contentView.snp.bottom).inset(1)
			$0.leading.trailing.equalTo(contentView)
		}
		
		notiLabel.snp.makeConstraints {
			$0.top.equalTo(contentView.snp.bottom).offset(3)
			$0.leading.equalTo(textField.snp.leading)
			$0.height.equalTo(22)
		}
		
	}
	
	public func setupType(type: TextFieldType) {
		self.type = type
		switch type {
		case .inactive:
			designLine.backgroundColor = .sesacGray3
			textField.textColor = .sesacGray7
		case .focus:
			designLine.backgroundColor = .sesacBlack
			textField.textColor = .sesacBlack
		case .active:
			designLine.backgroundColor = .sesacGray3
			textField.textColor = .sesacBlack
		case .disable:
			textField.textColor = .sesacGray7
			contentView.backgroundColor = .sesacGray3
		case .error:
			textField.textColor = .sesacBlack
			designLine.backgroundColor = .sesacError
			notiLabel.textColor = .sesacError
			notiLabel.isHidden = false
		case .success:
			textField.textColor = .sesacBlack
			designLine.backgroundColor = .sesacSuccess
			notiLabel.textColor = .sesacSuccess
			notiLabel.isHidden = false
		}
	}
	
	
	
}

//
//  NearSeSacTableCell.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/16.
//

import UIKit
import SnapKit

final class NearSeSacTableCell: UITableViewCell {
	
	let backgroundImageView = UIImageView()
	let faceImageView = UIImageView()
	let stackView = UIStackView()
	let userTitle = UserInfoTitle()
	let reputationView = ReputationView()
	let reviewView = ReviewView()
	let designView = UIView()
	let requestButton = UIButton()
	
	var arrowBtnAction: (() -> ())?
	var requestBtnAction: (() -> Void)?
	var isOpen = true
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setUpStackView()
		setupConstraint()
		configure()
		requestButtonConfigure()
		self.userTitle.arrowButton.addTarget(self, action: #selector(arrowButtonClicked(_:)), for: .touchUpInside)
		self.requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
	}
	
	@objc func requestButtonClicked() {
		requestBtnAction?()
	}
	
	@objc func arrowButtonClicked(_ sender: UIButton) {
////		self.userTitle.arrowButton.isSelected.toggle()
////		print("arrowBtnClicked in Cell Class")
////		print("======isopen",isOpen)
//		if isOpen {
//			reputationView.isHidden = true
//			reviewView.isHidden = true
//			userTitle.arrowButton.setImage(UIImage(named: "upArrow"), for: .normal)
//		} else {
//			reputationView.isHidden = false
//			reviewView.isHidden = false
//			userTitle.arrowButton.setImage(UIImage(named: "downArrow"), for: .normal)
//		}
//		isOpen.toggle()
		arrowBtnAction?()
	}
	
	func setUpStackView() {
		let stack = stackView
		stack.backgroundColor = .white
		stack.axis = .vertical
		stack.distribution = .fill
		stack.layer.cornerRadius = 8
		stack.layer.borderColor = UIColor.sesacGray2.cgColor
		stack.layer.borderWidth = 1
	}
	
	func configure() {
		backgroundImageView.image = UIImage(named: "back1")
		backgroundImageView.layer.cornerRadius = 8
		backgroundImageView.clipsToBounds = true
		faceImageView.image = UIImage(named: "face1")
		designView.backgroundColor = .white
	}
	
	func requestButtonConfigure() {
		requestButton.backgroundColor = .sesacError
		requestButton.setTitle("요청하기", for: .normal)
		requestButton.titleLabel?.font = SesacFont.title3M14.font
		requestButton.layer.cornerRadius = 8
	}
	
	func setupConstraint() {
		[backgroundImageView, faceImageView, stackView, designView, requestButton].forEach {
			contentView.addSubview($0)
		}
		
		[userTitle, reputationView, reviewView].forEach {
			stackView.addArrangedSubview($0)
		}
		
		backgroundImageView.snp.makeConstraints {
			$0.top.equalTo(designView.snp.bottom)
			$0.leading.trailing.equalTo(self).inset(16)
			$0.height.equalTo(194)
		}
		
		requestButton.snp.makeConstraints {
			$0.top.trailing.equalTo(backgroundImageView).inset(12)
			$0.width.equalTo(80)
			$0.height.equalTo(40)
		}
		
		faceImageView.snp.makeConstraints {
			$0.size.equalTo(184)
			$0.centerX.equalTo(self).offset(-10)
			$0.top.equalTo(backgroundImageView.snp.top).inset(19)
		}
		
		stackView.snp.makeConstraints {
			$0.top.equalTo(backgroundImageView.snp.bottom)
			$0.leading.trailing.equalTo(self).inset(16)
			$0.bottom.equalToSuperview()
		}
		
		userTitle.snp.makeConstraints {
			$0.top.equalTo(stackView.snp.top)
			$0.height.equalTo(58)
		}
		
		reputationView.snp.makeConstraints {
			$0.height.equalTo(154)
		}
		
		designView.snp.makeConstraints {
			$0.top.equalToSuperview()
			$0.leading.trailing.equalToSuperview()
			$0.height.equalTo(24)
		}
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

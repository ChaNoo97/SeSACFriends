//
//  NearSeSacTableCell.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/16.
//

import UIKit
import SnapKit

protocol ButtonActionDelegate: AnyObject {
	func arrowButtonClicked()
}

final class NearSeSacTableCell: UITableViewCell {
	
	let backgroundImageView = UIImageView()
	let faceImageView = UIImageView()
	let stackView = UIStackView()
	let userTitle = UserInfoTitle()
	let reputationView = ReputationView()
	let reviewView = ReviewView()
	let designView = UIView()
	
	weak var cellDelegate: ButtonActionDelegate?
	var isOpen = true
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setUpStackView()
		setupConstraint()
		configure()
		self.userTitle.arrowButton.addTarget(self, action: #selector(arrowButtonClicked(_:)), for: .touchUpInside)
	}
	
	@objc func arrowButtonClicked(_ sender: UIButton) {
		cellDelegate?.arrowButtonClicked()
		print("======isopen",isOpen)
		if isOpen {
			reputationView.isHidden = true
			reviewView.isHidden = true
			userTitle.arrowButton.setImage(UIImage(named: "upArrow"), for: .normal)
		} else {
			reputationView.isHidden = false
			reviewView.isHidden = false
			userTitle.arrowButton.setImage(UIImage(named: "downArrow"), for: .normal)
		}
		isOpen.toggle()
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
	
	func setupConstraint() {
		[backgroundImageView, faceImageView, stackView, designView].forEach {
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

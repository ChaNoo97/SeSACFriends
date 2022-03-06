//
//  CardView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/28.
//

import UIKit
import SnapKit

final class CardView: UIView {
	
	let backgroundImageView = UIImageView()
	let faceImageView = UIImageView()
	let stackView = UIStackView()
	let userTitle = UserInfoTitle()
	let reputationView = ReputationView()
	let reviewView = ReviewView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
		setUpStackView()
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
	}
	
	func setupConstraint() {
		[backgroundImageView, faceImageView, stackView].forEach {
			addSubview($0)
		}
		
		[userTitle, reputationView, reviewView].forEach {
			stackView.addArrangedSubview($0)
		}
		
		backgroundImageView.snp.makeConstraints {
			$0.top.equalToSuperview()
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
		
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

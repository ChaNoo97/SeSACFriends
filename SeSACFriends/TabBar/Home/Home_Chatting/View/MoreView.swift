//
//  MoreView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/22.
//

import UIKit
import SnapKit

final class MoreView: UIView, ViewProtocols {
	
	let stackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		return stack
	}()
	let reportButton = UIButton()
	let reportImage = UIImageView()
	let reportTitle = UILabel()
	
	let cancleButton = UIButton()
	let cancleImage = UIImageView()
	let cancleTitle = UILabel()
	
	let reviewButton = UIButton()
	let reviewImage = UIImageView()
	let reviewTitle = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	func configure() {
		reportImage.image = UIImage(named: "report")
		reportTitle.text = "새싹 신고"
		cancleImage.image = UIImage(named: "cancle")
		cancleTitle.text = "약속 취소"
		reviewImage.image = UIImage(named: "review")
		reviewTitle.text = "리뷰 등록"
		[reportTitle, cancleTitle, reviewTitle].forEach {
			$0.font = SesacFont.title3M14.font
		}
	}
	
	func setupConstraint() {
		addSubview(stackView)
		[reportButton, cancleButton, reviewButton].forEach {
			stackView.addArrangedSubview($0)
		}
		
		[reportImage, reportTitle].forEach {
			reportButton.addSubview($0)
		}
		
		[cancleImage, cancleTitle].forEach {
			cancleButton.addSubview($0)
		}
		
		[reviewImage, reviewTitle].forEach {
			reviewButton.addSubview($0)
		}
		
		stackView.snp.makeConstraints {
			$0.top.equalTo(self.safeAreaLayoutGuide)
			$0.height.equalTo(72)
			$0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
		}
		
		reportImage.snp.makeConstraints {
			$0.top.equalToSuperview().inset(11)
			$0.centerX.equalToSuperview()
			$0.size.equalTo(24)
		}
		
		reportTitle.snp.makeConstraints {
			$0.top.equalTo(reportImage.snp.bottom).offset(4)
			$0.centerX.equalToSuperview()
			$0.height.equalTo(22)
		}
		
		cancleImage.snp.makeConstraints {
			$0.top.equalToSuperview().inset(11)
			$0.centerX.equalToSuperview()
			$0.size.equalTo(24)
		}
		
		cancleTitle.snp.makeConstraints {
			$0.top.equalTo(cancleImage.snp.bottom).offset(4)
			$0.centerX.equalToSuperview()
			$0.height.equalTo(22)
		}
		
		reviewImage.snp.makeConstraints {
			$0.top.equalToSuperview().inset(11)
			$0.centerX.equalToSuperview()
			$0.size.equalTo(24)
		}
		
		reviewTitle.snp.makeConstraints {
			$0.top.equalTo(reviewImage.snp.bottom).offset(4)
			$0.centerX.equalToSuperview()
			$0.height.equalTo(22)
		}
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

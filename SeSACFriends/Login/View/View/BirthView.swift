//
//  BirthView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/23.
//

import UIKit
import SnapKit

public class BirthView: LoginBaseView, ViewProtocols {
	
	let titleLabel = UILabel()
	let stackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.spacing = 15
		stack.distribution = .fillEqually
		return stack
	}()
	let yearView = BirthSubView(frame: .zero)
	let monthView = BirthSubView(frame: .zero)
	let dayView = BirthSubView(frame: .zero)
	
	init() {
		super.init(frame: .zero, textType: .next)
		configure()
		setupConstraint()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func configure() {
		yearView.label.text = "년"
		yearView.textField.textField.placeholder = "1990"
		monthView.label.text = "월"
		monthView.textField.textField.placeholder = "1"
		dayView.label.text = "일"
		dayView.textField.textField.placeholder = "1"
		setupLabel(label: titleLabel, font: .display1R20, text: "생년월일을 알려주세요")
	}
	
	public override func setupConstraint() {
		super.setupConstraint()
		[stackView, titleLabel].forEach {
			addSubview($0)
		}
		[yearView, monthView, dayView].forEach {
			stackView.addArrangedSubview($0)
		}
		
		stackView.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(16)
			$0.centerX.equalToSuperview()
			$0.height.equalTo(48)
			$0.bottom.equalTo(mainButton.snp.top).offset(-72)
		}
		
		titleLabel.snp.makeConstraints {
			$0.bottom.equalTo(stackView.snp.top).offset(-80)
			$0.centerX.equalToSuperview()
			$0.height.equalTo(32)
		}
		
	}
	
}

//
//  GenderView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/24.
//

import UIKit
import SnapKit

public class GenderView: LoginBaseView, ViewProtocols {
	
	let stackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.spacing = 10
		stack.distribution = .fillEqually
		return stack
	}()
	let manButton = GenderButton(frame: .zero, type: .unSelect)
	let manButtonTitle = UILabel()
	let manImage = UIImageView()
	let womanButton = GenderButton(frame: .zero, type: .unSelect)
	let womanImage = UIImageView()
	let womanButtonTitle = UILabel()
	let titleLabel = UILabel()
	let subTitleLabel = UILabel()
	
	init() {
		super.init(frame: .zero, textType: .next)
		configure()
		setupConstraint()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func configure() {
		setupLabel(label: titleLabel, font: .display1R20, text: "성별을 선택해 주세요")
		setupLabel(label: subTitleLabel, font: .title2R16, text: "새싹 찾기 기능을 이용하기 위해서 필요해요!")
		subTitleLabel.textColor = .sesacGray7
		manImage.image = UIImage(named: "man")
		womanImage.image = UIImage(named: "woman")
		setupLabel(label: manButtonTitle, font: .title2R16, text: "남자")
		setupLabel(label: womanButtonTitle, font: .title2R16, text: "여자")
		
		
	}
	
	public override func setupConstraint() {
		
		super.setupConstraint()
		[stackView, titleLabel, subTitleLabel].forEach {
			addSubview($0)
		}
		
		[manButton, womanButton].forEach {
			stackView.addArrangedSubview($0)
		}
		
		[manButtonTitle, manImage].forEach {
			manButton.addSubview($0)
		}
		
		[womanButtonTitle, womanImage].forEach {
			womanButton.addSubview($0)
		}
		
		stackView.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.bottom.equalTo(mainButton.snp.top).offset(-32)
			$0.trailing.leading.equalTo(mainButton)
			$0.height.equalTo(120)
		}
		
		subTitleLabel.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.height.equalTo(26)
			$0.bottom.equalTo(stackView.snp.top).offset(-32)
		}
		
		titleLabel.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.height.equalTo(32)
			$0.bottom.equalTo(subTitleLabel.snp.top).offset(-8)
		}
		
		manImage.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.size.equalTo(64)
			$0.top.equalToSuperview().inset(14)
		}
		
		manButtonTitle.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.top.equalTo(manImage.snp.bottom).offset(2)
			$0.height.equalTo(26)
		}
		
		womanImage.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.size.equalTo(64)
			$0.top.equalToSuperview().inset(14)
		}
		
		womanButtonTitle.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.top.equalTo(womanImage.snp.bottom).offset(2)
			$0.height.equalTo(26)
		}
	}
	
}


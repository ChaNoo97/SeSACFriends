//
//  TabBarDesignView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/15.
//

import UIKit
import SnapKit

final class TabBarView: UIView, ViewProtocols {
	
	let tabBarView = UIView()
	let modifyHobbyButton = MainButton(frame: .zero, type: .fill, text: "취미변경하기")
	let reloadButton = UIButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	func configure() {
		reloadButton.setImage(UIImage(named: "refreshImage"), for: .normal)
		modifyHobbyButton.titleLabel?.font = SesacFont.body3R14.font
	}
	
	func setupConstraint() {
		[tabBarView, modifyHobbyButton, reloadButton].forEach {
			addSubview($0)
		}
		tabBarView.snp.makeConstraints {
			$0.height.equalTo(44)
			$0.leading.trailing.equalToSuperview()
			$0.top.equalTo(self.safeAreaLayoutGuide)
		}
		modifyHobbyButton.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(16)
			$0.trailing.equalTo(reloadButton.snp.leading).offset(-8)
			$0.height.equalTo(48)
			$0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
		}
		
		reloadButton.snp.makeConstraints {
			$0.trailing.equalToSuperview().inset(16)
			$0.size.equalTo(48)
			$0.centerY.equalTo(modifyHobbyButton.snp.centerY)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

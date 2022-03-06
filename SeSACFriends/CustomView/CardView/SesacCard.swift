//
//  SesacCard.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/03/06.
//

import UIKit
import SnapKit

final class SesacCard: UIView, ViewProtocols {
	
	let backgroundImageView = UIImageView()
	let faceImageView = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	
	func configure() {
		backgroundImageView.image = UIImage(named: "back1")
		backgroundImageView.layer.cornerRadius = 8
		backgroundImageView.clipsToBounds = true
		faceImageView.image = UIImage(named: "face1")
	}
	
	func setupConstraint() {
		[backgroundImageView, faceImageView].forEach {
			addSubview($0)
		}
		
		backgroundImageView.snp.makeConstraints {
			$0.top.equalToSuperview()
			$0.leading.trailing.equalToSuperview().inset(16)
			$0.height.equalTo(194)
		}
		
		faceImageView.snp.makeConstraints {
			$0.size.equalTo(184)
			$0.centerX.equalTo(self).offset(-10)
			$0.top.equalTo(backgroundImageView.snp.top).inset(19)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

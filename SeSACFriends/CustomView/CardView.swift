//
//  CardView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/28.
//

import UIKit
import SnapKit

public class CardView: UIView, ViewProtocols {
	
	let backgroundImageView = UIImageView()
	let faceImageView = UIImageView()
	let infoView = UIView()
	let titleLabel = UILabel()
	let moreButton = UIButton()
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	
	public func configure() {
		backgroundImageView.image = UIImage(named: "back1")
		backgroundImageView.layer.cornerRadius = 8
		backgroundImageView.clipsToBounds = true
		faceImageView.image = UIImage(named: "face1")
		infoView.backgroundColor = .sesacWhite
		infoView.layer.cornerRadius = 8
		//test
		titleLabel.text = "고래밥"
		titleLabel.font = SesacFont.title1M16.font
		moreButton.setImage(UIImage(named: "moreArrow"), for: .normal)
		moreButton.tintColor = .black
	}
	
	public func setupConstraint() {
		
		[backgroundImageView, faceImageView, infoView].forEach {
			addSubview($0)
		}
		
		[titleLabel, moreButton].forEach {
			infoView.addSubview($0)
		}
		
		backgroundImageView.snp.makeConstraints {
//			$0.leading.top.trailing.equalTo(self)
			$0.leading.trailing.equalTo(self)
			$0.top.equalTo(self).offset(100)
			$0.height.equalTo(194)
		}
		
		faceImageView.snp.makeConstraints {
			$0.size.equalTo(184)
			$0.centerX.equalTo(self).offset(-10)
			$0.top.equalTo(backgroundImageView.snp.top).inset(19)
		}
		
		infoView.snp.makeConstraints {
			$0.top.equalTo(backgroundImageView.snp.bottom)
			$0.leading.trailing.equalTo(self)
			$0.height.equalTo(58)
		}
		
		titleLabel.snp.makeConstraints {
			$0.leading.top.equalTo(16)
			$0.height.equalTo(26)
		}
		
		moreButton.snp.makeConstraints {
			$0.top.equalTo(26)
			$0.trailing.equalTo(18)
			$0.width.equalTo(6)
			$0.height.equalTo(12)
		}
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
}
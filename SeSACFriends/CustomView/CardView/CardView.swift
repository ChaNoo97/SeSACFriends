//
//  CardView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/28.
//

import UIKit
import SnapKit

//MARK: 상속예정에 있음
class CardView: UIView, ViewProtocols {
	
	let backgroundImageView = UIImageView()
	let faceImageView = UIImageView()
	let infoTableView = UITableView()
	
	
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
		infoTableView.backgroundColor = .red
	}
	
	func setupConstraint() {
		
		[backgroundImageView, faceImageView, infoTableView].forEach {
			addSubview($0)
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
		
		infoTableView.snp.makeConstraints {
			$0.leading.trailing.equalTo(backgroundImageView)
			$0.top.equalTo(backgroundImageView.snp.bottom)
			$0.height.equalTo(310)
		}
		
	}
		
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

//
//  MyInfoManageView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/03.
//

import UIKit
import SnapKit

class MyInfoManageView: UIView {
	
	let myInfoCardView = CardView()
	let bottomView = BottomView()
	let scrollView = UIScrollView()
	let contentView = UIView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConstraint()
		myInfoCardView.backgroundColor = .red
	}
	
	func setupConstraint() {
		
		addSubview(scrollView)
		scrollView.addSubview(contentView)
		
		[myInfoCardView, bottomView].forEach {
			contentView.addSubview($0)
		}
		
		scrollView.snp.makeConstraints {
			$0.edges.equalTo(self.safeAreaLayoutGuide)
		}
		
		contentView.snp.makeConstraints {
			$0.edges.equalToSuperview()
			$0.width.equalTo(UIScreen.main.bounds.width)
			$0.height.equalTo(2000)
		}
		
		myInfoCardView.snp.makeConstraints {
			$0.leading.trailing.top.equalTo(contentView)
			$0.bottom.equalTo(bottomView.snp.top).offset(24)
		}
		
		bottomView.snp.makeConstraints {
			$0.leading.trailing.equalTo(contentView).inset(16)
			$0.top.equalTo(myInfoCardView.snp.bottom).offset(24)
			$0.height.equalTo(320)
		}
		
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	

}

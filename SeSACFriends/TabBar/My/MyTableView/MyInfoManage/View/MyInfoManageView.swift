//
//  MyInfoManageView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/03.
//

import UIKit
import SnapKit

final class MyInfoManageView: UIView {
	
	let myInfoCardView = CardView()
	let bottomView = BottomView()
	let scrollView = UIScrollView()
	let contentView = UIView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConstraint()
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
		}
		
		myInfoCardView.snp.makeConstraints {
			$0.leading.trailing.top.equalTo(contentView)
			
		}
		
		bottomView.snp.makeConstraints {
			$0.leading.trailing.equalTo(contentView).inset(16)
			$0.top.equalTo(myInfoCardView.snp.bottom).offset(24)
			$0.bottom.equalTo(contentView).inset(150)
		}
		
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	

}

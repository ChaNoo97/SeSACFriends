//
//  ReputationView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/30.
//

import UIKit
import SnapKit

class ReputationView: UIView, ViewProtocols {
	
	let title = UILabel()
	let horizontalStackView1 = UIStackView()
	let horizontalStackView2 = UIStackView()
	let horizontalStackView3 = UIStackView()
	let reputationLabel1 = UILabel()
	let reputationLabel2 = UILabel()
	let reputationLabel3 = UILabel()
	let reputationLabel4 = UILabel()
	let reputationLabel5 = UILabel()
	let reputationLabel6 = UILabel()
	
	let verticalStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = 8
		stack.distribution = .fillEqually
		return stack
	}()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	
	func configure() {
		[horizontalStackView1, horizontalStackView2, horizontalStackView3].forEach {
			$0.axis = .horizontal
			$0.spacing = 8
			$0.distribution = .fillEqually
		}
		title.text = "새싹 타이틀"
		title.font = SesacFont.title6R12.font
		reputationLabel1.text = "좋은매너"
		reputationLabel2.text = "정확한 시간 약속"
		reputationLabel3.text = "빠른 응답"
		reputationLabel4.text = "친절한 성격"
		reputationLabel5.text = "능숙한 취미 실력"
		reputationLabel6.text = "유익한 시간"
		[reputationLabel1,reputationLabel2,reputationLabel3,reputationLabel4,reputationLabel5,reputationLabel6].forEach{
			$0.font = SesacFont.title4R14.font
			$0.textColor = .black
			$0.textAlignment = .center
			$0.layer.cornerRadius = 8
			$0.layer.borderColor = UIColor.sesacGray4.cgColor
			$0.layer.borderWidth = 1
		}
	}
	
	func setupConstraint() {
		addSubview(title)
		addSubview(verticalStackView)
		
		[reputationLabel1, reputationLabel2].forEach{
			horizontalStackView1.addArrangedSubview($0)
		}
		
		[reputationLabel3, reputationLabel4].forEach{
			horizontalStackView2.addArrangedSubview($0)
		}
		
		[reputationLabel5, reputationLabel6].forEach{
			horizontalStackView3.addArrangedSubview($0)
		}
		
		[horizontalStackView1, horizontalStackView2, horizontalStackView3].forEach {
			verticalStackView.addArrangedSubview($0)
		}
		
		title.snp.makeConstraints {
			$0.top.equalTo(self).offset(8)
			$0.leading.equalTo(self).inset(16)
			$0.height.equalTo(18)
		}
		
		verticalStackView.snp.makeConstraints {
			$0.top.equalTo(title.snp.bottom).offset(16)
			$0.height.equalTo(112)
			$0.leading.trailing.equalTo(self).inset(16)
		}
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

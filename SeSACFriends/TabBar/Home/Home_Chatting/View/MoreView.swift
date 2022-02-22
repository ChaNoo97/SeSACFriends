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
	let cancleButton = UIButton()
	let reviewButton = UIButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	func configure() {
		reportButton.setImage(UIImage(named: "report"), for: .normal)
		cancleButton.setImage(UIImage(named: "cancle"), for: .normal)
		reviewButton.setImage(UIImage(named: "review"), for: .normal)
	}
	
	func setupConstraint() {
		addSubview(stackView)
		[reportButton, cancleButton, reviewButton].forEach {
			stackView.addArrangedSubview($0)
		}
		
		stackView.snp.makeConstraints {
			$0.top.equalTo(self.safeAreaLayoutGuide)
			$0.height.equalTo(72)
			$0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
		}
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

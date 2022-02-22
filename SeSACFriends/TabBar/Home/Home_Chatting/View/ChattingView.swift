//
//  ChattingView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/22.
//

import UIKit
import SnapKit

final class ChattingView: UIView, ViewProtocols {
	
	let tableView = UITableView()
	let chatView = UIView()
	let contentView = UITextView()
	let sendButton = UIButton()
	let moreView = MoreView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	func configure() {
		chatView.backgroundColor = .sesacGray1
		chatView.layer.cornerRadius = 8
		contentView.font = SesacFont.body3R14.font
		contentView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		contentView.backgroundColor = .sesacGray1
		sendButton.setImage(UIImage(named: "inactive"), for: .normal)
		moreView.isHidden = true
		moreView.stackView.backgroundColor = .white
		moreView.stackView.alpha = 0
		moreView.backgroundColor = .black.withAlphaComponent(0.5)
	}
	
	func setupConstraint() {
		[tableView, chatView, moreView].forEach {
			addSubview($0)
		}
		
		[contentView, sendButton].forEach {
			chatView.addSubview($0)
		}
		
		tableView.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview()
			$0.top.equalTo(self.safeAreaLayoutGuide)
			$0.bottom.equalTo(chatView.snp.top)
		}
		
		chatView.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview().inset(16)
//			$0.height.equalTo(52)
			$0.bottom.equalTo(self.safeAreaLayoutGuide)
		}
		
		contentView.snp.makeConstraints {
			$0.top.bottom.equalToSuperview().inset(14)
			$0.height.equalTo(24)
			$0.leading.equalToSuperview().inset(12)
			$0.trailing.equalTo(sendButton.snp.leading).offset(-8)
		}
		
		sendButton.snp.makeConstraints {
			$0.trailing.equalToSuperview().inset(12)
			$0.centerY.equalToSuperview()
			$0.size.equalTo(24)
		}
		
		moreView.snp.makeConstraints {
			$0.top.equalTo(self.safeAreaLayoutGuide)
			$0.bottom.equalToSuperview()
			$0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

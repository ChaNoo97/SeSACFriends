//
//  FindNearView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/15.
//

import UIKit
import SnapKit

class FindNearView: UIView, ViewProtocols {
	
	
	let tableView = UITableView()
	let emptyView = EmptyView()
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
		[tableView, modifyHobbyButton, reloadButton].forEach {
			addSubview($0)
		}
		
		tableView.addSubview(emptyView)
		
		tableView.snp.makeConstraints {
			$0.edges.equalTo(self.safeAreaLayoutGuide)
		}
		
		emptyView.snp.makeConstraints {
			$0.center.equalTo(self)
			$0.width.equalTo(263)
			$0.height.equalTo(158)
		}
		
		modifyHobbyButton.snp.makeConstraints {
			$0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
			$0.leading.equalToSuperview().inset(16)
			$0.height.equalTo(48)
		}
		
		reloadButton.snp.makeConstraints {
			$0.centerY.equalTo(modifyHobbyButton.snp.centerY)
			$0.trailing.equalToSuperview().inset(16)
			$0.leading.equalTo(modifyHobbyButton.snp.trailing).offset(8)
			$0.size.equalTo(48)
		}
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

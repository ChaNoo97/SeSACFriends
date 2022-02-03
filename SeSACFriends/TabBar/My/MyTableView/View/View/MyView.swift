//
//  MyView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/27.
//

import UIKit
import SnapKit

final class MyView: UIView {
	
	let tableView = UITableView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConstraint()
	}
	
	
	func setupConstraint() {
		addSubview(tableView)
		tableView.snp.makeConstraints {
			$0.edges.equalTo(self.safeAreaLayoutGuide)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

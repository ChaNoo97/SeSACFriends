//
//  ViewProtocols.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/21.
//

import Foundation
import UIKit

protocol ViewProtocols {
	func configure()
	func setupConstraint()
}


class BaseView: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	func configure() { }
	
	func setupConstraint() { }
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//
//  UITableView+extension.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/28.
//

import UIKit

protocol ResuableView {
	static var reuseIdentfier: String { get }
}

extension UITableViewCell: ResuableView {
	static var reuseIdentfier: String {
		return String(describing: self)
	}
	
	
}

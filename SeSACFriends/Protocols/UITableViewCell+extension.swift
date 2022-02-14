//
//  UITableView+extension.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/28.
//

import UIKit

protocol ReuseableView {
	static var reuseIdentfier: String { get }
}

extension UITableViewCell: ReuseableView {
	static var reuseIdentfier: String {
		return String(describing: self)
	}
	
	
}



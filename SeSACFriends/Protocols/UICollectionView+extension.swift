//
//  UICollectionView+extension.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/12.
//

import UIKit

extension UICollectionViewCell: ReuseableView {
	static var reuseIdentfier: String {
		return String(describing: self)
	}
	
}

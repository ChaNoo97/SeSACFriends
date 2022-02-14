//
//  CollectionHeaderView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/13.
//

import UIKit
import SnapKit

final class CollectionHeaderView: UICollectionReusableView {
	
	static let identifier = "CollectionHeaderView"
	
	let headerLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setUpConstraints()
	}
	
	func configure() {
		headerLabel.font = SesacFont.title6R12.font
	}
	
	func setUpConstraints() {
		self.addSubview(headerLabel)
		headerLabel.snp.makeConstraints {
			$0.bottom.equalToSuperview().inset(16)
			$0.top.equalToSuperview()
			$0.leading.equalToSuperview()
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
}

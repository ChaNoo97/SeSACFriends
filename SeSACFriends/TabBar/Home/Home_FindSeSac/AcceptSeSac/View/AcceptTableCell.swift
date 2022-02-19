//
//  AcceptTableCell.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/16.
//

import Foundation


final class AcceptTableCell: NearSeSacTableCell {
	
	override init(style: NearSeSacTableCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
	}
	
	
	override func configure() {
		super.configure()
		requestButton.backgroundColor = .sesacSuccess
		requestButton.setTitle("수락하기", for: .normal)
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

//
//  HobbyView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/11.
//

import UIKit
import SnapKit

final class HobbyView: UIView, ViewProtocols {
	
	let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 10
		layout.scrollDirection = .vertical
		layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		return cv
	}()
	let findButton = MainButton(frame: .zero, type: .fill, text: "새싹 찾기")
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	
	func configure() {
		
	}
	
	func setupConstraint() {
		
		addSubview(collectionView)
		addSubview(findButton)
		
		collectionView.snp.makeConstraints {
			$0.leading.trailing.top.equalTo(self.safeAreaLayoutGuide)
			$0.bottom.equalTo(findButton.snp.top)
		}
		
		findButton.snp.makeConstraints {
			$0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
			$0.left.trailing.equalToSuperview().inset(16)
			$0.height.equalTo(48)
		}
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

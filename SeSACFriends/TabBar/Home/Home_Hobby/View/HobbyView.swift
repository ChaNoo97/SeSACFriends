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
		layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 34)
		layout.minimumInteritemSpacing = 10
		layout.minimumLineSpacing = 10
		layout.scrollDirection = .vertical
		layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		layout.itemSize = CGSize(width: 80, height: 32)
		
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		return cv
	}()
	let findButton = MainButton(frame: .zero, type: .fill, text: "새싹 찾기")
	let searchBar = UISearchBar()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
		setupConstraint()
	}
	
	
	func configure() {
		searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
	}
	
	func setupConstraint() {
		
		addSubview(collectionView)
		addSubview(findButton)
		
		collectionView.snp.makeConstraints {
			$0.leading.trailing.top.equalTo(self.safeAreaLayoutGuide).inset(16)
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

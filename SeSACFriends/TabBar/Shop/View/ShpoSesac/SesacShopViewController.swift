//
//  SesacShopViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/03/05.
//

import UIKit
import SnapKit

class SesacShopViewController: UIViewController {
	
	let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
		layout.minimumLineSpacing = 24
		layout.minimumInteritemSpacing = 12
		layout.scrollDirection = .vertical
		let itemWidth = (UIScreen.main.bounds.width - 44)/2
		layout.itemSize = CGSize(width: itemWidth, height: (itemWidth)*1.5909)
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		return cv
	}()
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
       setUpConstraints()
		setUpCollectionView()
    }
	
	func setUpConstraints() {
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints {
			$0.top.equalTo(view.safeAreaLayoutGuide).offset(253)
			$0.leading.trailing.equalToSuperview()
			$0.bottom.equalTo(view.safeAreaLayoutGuide)
		}
	}
	
	func setUpCollectionView() {
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(SesacFaceCell.self, forCellWithReuseIdentifier: SesacFaceCell.reuseIdentfier)
	}
    
}

extension SesacShopViewController: UICollectionViewDataSource, UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SesacFaceCell.reuseIdentfier, for: indexPath) as? SesacFaceCell else { return UICollectionViewCell() }
		cell.imageViwe.image = sesacImageEnum.face1.image
		cell.titleLable.text = "민트새싹"
		cell.subTitleLabel.text = "새싹을 대표하는 기본 식물입니다. 다른 새싹들과 함께 하는 것을 좋아합니다."
		return cell
	}


}

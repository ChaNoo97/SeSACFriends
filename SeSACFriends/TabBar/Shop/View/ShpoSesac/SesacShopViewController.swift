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
	
	let viewModel = ShopViewModel.shared
	
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
		let row = indexPath.row
		cell.imageViwe.image = sesacImageEnum(rawValue: row)?.image
		cell.titleLable.text = viewModel.sesacImageTitle[row]
		cell.subTitleLabel.text = viewModel.sesacImageSubtitle[row]
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		viewModel.presentImage.value = indexPath.row
	}


}

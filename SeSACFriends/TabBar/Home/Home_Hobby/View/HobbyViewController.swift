//
//  HobbyViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/11.
//

import UIKit

class HobbyViewController: BaseViewController {
	
	let mainView = HobbyView()
	let viewModel = HobbyViewModel()
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		tabBarHidden()
		navBarDisplay()
		navigationBarSetting()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.titleView = mainView.searchBar
		mainView.collectionView.dataSource = self
		mainView.collectionView.delegate = self
		mainView.collectionView.register(HobbyServerCell.self, forCellWithReuseIdentifier: HobbyServerCell.reuseIdentfier)
		mainView.collectionView.register(HobbyClientCell.self, forCellWithReuseIdentifier: HobbyClientCell.reuseIdentfier)
		mainView.collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.identifier)
    }

}

extension HobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if section == 0 {
			return viewModel.recommendArray.count + viewModel.testArray.count
		} else {
			return viewModel.myHobbyArray.value.count
		}
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if indexPath.section == 0 {
			guard let cell1 = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: HobbyServerCell.reuseIdentfier, for: indexPath) as? HobbyServerCell else { return UICollectionViewCell() }
			let row = indexPath.row
			if row >= 0 && row < viewModel.recommendArray.count {
				cell1.textLabel.text = viewModel.recommendArray[row]
				cell1.shallView.layer.borderColor = UIColor.sesacError.cgColor
				cell1.textLabel.textColor = .sesacError
			} else {
				let index = row - (viewModel.recommendArray.count)
				cell1.textLabel.text = viewModel.testArray[index]
			}
			cell1.backgroundColor = .yellow
			return cell1
		} else {
			guard let cell2 = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: HobbyClientCell.reuseIdentfier, for: indexPath) as? HobbyClientCell else { return UICollectionViewCell() }
			let row = indexPath.row
			cell2.textLabel.text = viewModel.myHobbyArray.value[row]
			return cell2
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		if indexPath.section == 0 {
			let row = indexPath.row
			if row >= 0 && row < viewModel.recommendArray.count {
				let label = UILabel()
				label.font = SesacFont.title4R14.font
				label.sizeToFit()
				label.text = viewModel.recommendArray[row]
				let size = label.frame.size
				print("----------", size)
				return CGSize(width: size.width + 32, height: size.height + 10)
			} else {
				let label = UILabel()
				label.font = SesacFont.title4R14.font
				label.sizeToFit()
				let index = row - (viewModel.recommendArray.count)
				label.text = viewModel.testArray[index]
				let size = label.frame.size
				print("----------++++", size)
				return CGSize(width: size.width + 32, height: size.height + 10)
			}
		} else {
			let label = UILabel()
			label.font = SesacFont.title4R14.font
			label.sizeToFit()
			let row = indexPath.row
			label.text = viewModel.myHobbyArray.value[row]
			let size = label.frame.size
			return CGSize(width: size.width + 32, height: size.height + 10)
		}
	}
	
	//collectionHeaderView
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		switch kind {
		case UICollectionView.elementKindSectionHeader:
			if indexPath.section == 0 {
				guard let header = mainView.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.identifier, for: indexPath) as? CollectionHeaderView else { return UICollectionReusableView() }
				header.headerLabel.text = "지금 주변에는"
				return header
			} else {
				guard let header = mainView.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.identifier, for: indexPath) as? CollectionHeaderView else { return UICollectionReusableView() }
				header.headerLabel.text = "내가 하고 싶은"
				return header
			}
			
		default:
			assert(false)
		}
	}
	
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//		return CGSize(width: mainView.collectionView.frame.width, height: 18)
//		}


}

//
//  HobbyViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/11.
//

import UIKit

class HobbyViewController: BaseViewController {
	
	let mainView = HobbyView()
	
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
		
		
		
    }


}

//extension HobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		return 2
//	}
//
//	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//	}
//
//
//}

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
		let searchBar = UISearchBar()
		searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
		self.navigationItem.titleView = searchBar
    }


}

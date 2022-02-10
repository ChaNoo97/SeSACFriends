//
//  HobbyViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/11.
//

import UIKit

class HobbyViewController: BaseViewController {
	
	override func viewWillAppear(_ animated: Bool) {
		tabBarHidden()
		navBarDisplay()
		navigationBarSetting()
		
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .red
    }


}

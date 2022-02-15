//
//  AcceptViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/15.
//

import UIKit
import SnapKit
import Tabman

final class AcceptViewController: UIViewController {
	
	let mainView = acceptView()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//onqueue 호출
	}
	
	override func loadView() {
		self.view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
		
    }

}

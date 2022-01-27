//
//  ShopViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/27.
//

import UIKit
import SnapKit

public class ShopViewController: BaseViewController {
	
	let mainView = ShopView()
	
	public override func loadView() {
		self.view = mainView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		navigationBarSetTitle(title: "새싹샵")
	}
	
}

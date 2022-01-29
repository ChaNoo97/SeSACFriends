//
//  CardViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/28.
//

import Foundation
import UIKit


public class CardViewController: UIViewController {
	
	let mainView = CardView()
	
	public override func loadView() {
		self.view = mainView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
}

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
	
	var buttonStatus = true
	
	public override func loadView() {
		self.view = mainView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		mainView.moreButton.addTarget(self, action: #selector(moreButtonClicked), for: .touchUpInside)
	}
	
	@objc func moreButtonClicked() {
		
		if buttonStatus {
			mainView.moreButton.setImage(UIImage(named: "upArrow"), for: .normal)
			mainView.infoView.snp.updateConstraints {
				$0.height.equalTo(300)
			} 
		} else {
			mainView.moreButton.setImage(UIImage(named: "downArrow"), for: .normal)
			mainView.infoView.snp.updateConstraints {
				$0.height.equalTo(58)
			}
		}
		buttonStatus.toggle()
	}
	
}

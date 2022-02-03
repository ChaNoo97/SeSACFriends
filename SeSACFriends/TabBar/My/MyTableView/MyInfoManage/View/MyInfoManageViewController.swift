//
//  MyInfoManageViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/02.
//

import UIKit

class MyInfoManageViewController: BaseViewController {
	
	let mainView = MyInfoManageView()
	
	var profileIsOpen = true
	
	override func loadView() {
		self.view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
//		testView.userTitle.arrowButton.addTarget(self, action: #selector(arrowBtnClicked), for: .touchUpInside)
//
//		test.manButton.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
//		test.womanButton.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
      
    }
	
	@objc func manButtonClicked() {
		
	}
	
	@objc func womanButtonClicked() {
		
	}
    
//	@objc func arrowBtnClicked() {
//		if profileIsOpen {
//			testView.reputationView.isHidden = true
//			testView.reviewView.isHidden = true
//			testView.userTitle.arrowButton.setImage(UIImage(named: "upArrow"), for: .normal)
//		} else {
//			testView.reputationView.isHidden = false
//			testView.reviewView.isHidden = false
//			testView.userTitle.arrowButton.setImage(UIImage(named: "downArrow"), for: .normal)
//		}
//		profileIsOpen.toggle()
//		
//	}
   

}

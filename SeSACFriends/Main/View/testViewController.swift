//
//  testViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/02.
//

import UIKit

class testViewController: UIViewController {
	
	let testView = CardView()
	
	var profileIsOpen = true
	
	override func loadView() {
		self.view = testView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		testView.userTitle.arrowButton.addTarget(self, action: #selector(arrowBtnClicked), for: .touchUpInside)
      
    }
    
	@objc func arrowBtnClicked() {
		if profileIsOpen {
			testView.reputationView.isHidden = true
			testView.reviewView.isHidden = true
			testView.userTitle.arrowButton.setImage(UIImage(named: "upArrow"), for: .normal)
		} else {
			testView.reputationView.isHidden = false
			testView.reviewView.isHidden = false
			testView.userTitle.arrowButton.setImage(UIImage(named: "downArrow"), for: .normal)
		}
		profileIsOpen.toggle()
		
	}
   

}

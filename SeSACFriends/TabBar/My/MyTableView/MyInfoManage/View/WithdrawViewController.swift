//
//  WithdrawViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/04.
//

import UIKit
import SnapKit

class WithdrawViewController: UIViewController {
	
	let button = UIButton()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		config()
		view.backgroundColor = .red
		button.backgroundColor = .blue
		button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
	func config() {
		view.addSubview(button)
		button.snp.makeConstraints { make in
			make.size.equalTo(100)
			make.center.equalToSuperview()
		}
	}
	
	@objc func buttonClicked() {
		dismiss(animated: true, completion: nil)
	}
    

}

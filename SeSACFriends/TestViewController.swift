//
//  TestViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/22.
//

import UIKit
import SnapKit

class TestViewController: BaseViewController {
	
	let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
		view.addSubview(button)
		button.snp.makeConstraints {
			$0.size.equalTo(50)
			$0.center.equalToSuperview()
		}
		
		button.backgroundColor = .red
		
		button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
	@objc func buttonClicked() {
		pushViewCon(vc: ChattingViewController())
	}
}

//
//  ViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
	let textfield = MainTextField(frame: .zero, type: .inactive)
	let textfield2 = MainTextField(frame: .zero, type: .disable)
	let textfield3 = MainTextField(frame: .zero, type: .error)
	let button = UIButton()
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		view.addSubview(button)
		view.addSubview(textfield2)
		view.addSubview(textfield3)
		button.backgroundColor = .sesacWhitegreen
		
		button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
		
		button.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.height.equalTo(48)
			$0.width.equalToSuperview().multipliedBy(0.8)
		}
		
		textfield3.snp.makeConstraints {
			$0.bottom.equalTo(button.snp.top).offset(-10)
			$0.height.equalTo(48)
			$0.width.equalTo(button)
			$0.centerX.equalTo(button)
		}
		
		textfield3.notiLabel.text = "실패!"
	}
	
	@objc func buttonClicked() {
		textfield3.setupType(type: .success)
	}


}


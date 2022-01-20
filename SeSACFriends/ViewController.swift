//
//  ViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
	let lable = UILabel()
	let label2 = UILabel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		lable.font = SesacFont.title1M16.font
		lable.text = "되나요?"
		label2.font = SesacFont.title5M12.font
		label2.text = "폰트테스트"
		view.addSubview(lable)
		view.addSubview(label2)
		lable.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.size.equalTo(100)
		}
		label2.snp.makeConstraints {
			$0.top.equalTo(lable.snp.bottom).offset(10)
			$0.size.equalTo(100)
		}
		lable.backgroundColor = .sesacGreen
		label2.backgroundColor = .sesacWhitegreen
	}


}


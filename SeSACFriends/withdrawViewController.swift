//
//  HomeViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/25.
//

import UIKit
import SnapKit

class withdrawViewController: UIViewController {
	let button = UIButton()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(button)
		button.backgroundColor = .white
		button.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.size.equalTo(100)
		}
		button.addTarget(self, action: #selector(buttonclicked), for: .touchUpInside)
	}
	
	@objc func buttonclicked() {
		print("??")
		UserApiService.withdraw { statusCode, error in
			if let error = error {
				return
			}
			if let statusCode = statusCode {
				//200 -> 온보딩, 401 파베토큰오류, 406 처리된 회원, 500 서버에러
				print(statusCode)
				UserDefaults.standard.removeObject(forKey: UserDefaultsKey.idToken.rawValue)
			}
		}
	}
}

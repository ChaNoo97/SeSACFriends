//
//  InitialViewComtroller.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/26.
//

import UIKit
import JGProgressHUD
import SnapKit
import FirebaseAuth

public class InitialViewcontroller: BaseViewController {
	
	let centerView = UIView()
	let lunchImageView = UIImageView()
	let lunchTitleImageView = UIImageView()
	let hud = JGProgressHUD()
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupConstraint()
		setupProgressHud()
		FIRAuth.renewIdToken()
		if let idtoken = UserDefaults.standard.string(forKey: UserDefaultsKey.idToken.rawValue) {
			LoginApiService.logIn { data, code, error in
				switch code {
				case 200:
					self.hud.dismiss(animated: true)
					self.changeRootView(viewController: withdrawViewController())
				case 201:
					self.hud.dismiss(animated: true)
					self.changeRootView(viewController: NickNameViewController())
				default:
					self.hud.dismiss(animated: true)
					return
				}
			}
		} else {
			hud.dismiss(animated: true)
			changeRootView(viewController: LoginViewController())
		}
		
	}
	
}

extension InitialViewcontroller {
	
	public func setupProgressHud() {
		hud.textLabel.text = "Loading"
		hud.show(in: self.view)
	}
	
	public func setupConstraint() {
		view.addSubview(centerView)
		[lunchImageView, lunchTitleImageView].forEach {
			centerView.addSubview($0)
		}
		
		centerView.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.height.equalToSuperview().multipliedBy(0.46)
			$0.width.equalToSuperview().multipliedBy(0.78)
		}
		
		lunchImageView.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.top.equalTo(centerView.snp.top)
			$0.height.equalTo(view).multipliedBy(0.33)
			$0.width.equalTo(view).multipliedBy(0.58)
		}
		
		lunchTitleImageView.snp.makeConstraints {
			$0.centerX.equalToSuperview()
			$0.bottom.equalTo(centerView.snp.bottom)
			$0.height.equalTo(view).multipliedBy(0.12)
			$0.width.equalTo(centerView)
		}
		
		lunchImageView.image = UIImage(named: "splashImg")
		lunchTitleImageView.image = UIImage(named: "splashText")
		lunchTitleImageView.contentMode = .scaleAspectFit
	}
}

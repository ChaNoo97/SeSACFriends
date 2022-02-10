//
//  WithdrawViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/04.
//

import UIKit
import SnapKit

final class WithdrawViewController: BaseViewController {
	
	let mainView = PopUpView(frame: .zero, title: "정말 탈퇴하시겠습니까?", subTitle: "탈퇴하시면 새싹 프렌즈를 이용할 수 없어요ㅠ", cnacelTitle: "취소", allowTitle: "확인")
	
	override func loadView() {
		self.view = mainView
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .black.withAlphaComponent(0.5)
		mainView.allowButton.addTarget(self, action: #selector(allowButtonClicked), for: .touchUpInside)
		mainView.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    }
    
	@objc func allowButtonClicked() {
		UserApiService.withdraw { statusCode, error in
			if let error = error {
				return
			}
			if let statusCode = statusCode {
				UserDefaults.standard.removeObject(forKey: UserDefaultsKey.idToken.rawValue)
				self.changeRootNavView(viewController: InitialViewcontroller())
			}
		}
	}
	
	@objc func cancelButtonClicked() {
		self.dismiss(animated: true, completion: nil)
	}
	
	
    

}

//
//  CanclePopupViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/23.
//

import UIKit

class CanclePopupViewController: UIViewController {
	
	let mainView = PopUpView(frame: .zero, title: "약속을 취소하겠습니까?", subTitle: "약속을 취소하시면 패널티가 부과됩니다", cnacelTitle: "취소", allowTitle: "확인")
	let viewModel = ChattingViewModel.shared
	
	override func loadView() {
		self.view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		mainView.cancelButton.addTarget(self, action: #selector(cancleButtonClicked), for: .touchUpInside)
		mainView.allowButton.addTarget(self, action: #selector(allowButtonClicked), for: .touchUpInside)
    }

	@objc func cancleButtonClicked() {
		dismiss(animated: true, completion: nil)
	}
	
	@objc func allowButtonClicked() {
		print("allow")
		viewModel.dodge { message, viewController in
			if let viewController = viewController {
				self.changeRootView(viewController: viewController)
			}
			if let message = message {
				self.view.makeToast(message)
			}
		}
	}
}

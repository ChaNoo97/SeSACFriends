//
//  RequestPopUpViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/20.
//

import UIKit

class RequestPopUpViewController: UIViewController {
	
	var requestClosure: (() -> ())?
	
	let mainView = PopUpView(frame: .zero, title: "취미 같이 하기를 요청할게요!", subTitle: "요청이 수락되면 30분 후에 리뷰를 남길 수 있어요", cnacelTitle: "취소", allowTitle: "확인")

	override func loadView() {
		self.view = mainView
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .black.withAlphaComponent(0.5)
       
		mainView.allowButton.addTarget(self, action: #selector(allowButtonClicked), for: .touchUpInside)
		mainView.cancelButton.addTarget(self, action: #selector(cancleButtonClicked), for: .touchUpInside)
    }
	
	@objc func allowButtonClicked() {
		requestClosure!()
		dismiss(animated: true, completion: nil)
	}
	
	@objc func cancleButtonClicked() {
		dismiss(animated: true, completion: nil)
	}

}

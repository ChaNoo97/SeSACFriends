//
//  AcceptPopUpViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/21.
//

import UIKit

class AcceptPopUpViewController: UIViewController {
	
	var acceptClosure: (() -> ())?
	
	let mainView = PopUpView(frame: .zero, title: "취미 같이 하기를 수락할까요?", subTitle: "요청을 수락하면 채팅창에서 대화를 나눌 수 있어요", cnacelTitle: "취소", allowTitle: "확인")
	
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
		acceptClosure!()
		dismiss(animated: true, completion: nil)
	}
	
	@objc func cancleButtonClicked() {
		dismiss(animated: true, completion: nil)
	}
    
	

    

}

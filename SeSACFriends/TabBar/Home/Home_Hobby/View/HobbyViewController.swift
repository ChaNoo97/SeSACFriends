//
//  HobbyViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/11.
//

import UIKit
import SnapKit
import Toast

class HobbyViewController: BaseViewController {
	
	let mainView = HobbyView()
	let viewModel = HobbyViewModel()
	var buttonStatus = true
	var standByArray: [String] = []
	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		tabBarHidden()
		navBarDisplay()
		navigationBarSetting()
		viewModel.onQueue {
			self.mainView.collectionView.reloadData()
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.titleView = mainView.searchBar
		mainView.collectionView.dataSource = self
		mainView.collectionView.delegate = self
		mainView.searchBar.delegate = self
		mainView.collectionView.register(HobbyRecommendCell.self, forCellWithReuseIdentifier: HobbyRecommendCell.reuseIdentfier)
		mainView.collectionView.register(HobbyHfCell.self, forCellWithReuseIdentifier: HobbyHfCell.reuseIdentfier)
		mainView.collectionView.register(HobbyClientCell.self, forCellWithReuseIdentifier: HobbyClientCell.reuseIdentfier)
		mainView.collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.identifier)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardShow(notification:)),
			name: UIResponder.keyboardWillChangeFrameNotification,
			object: nil)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardHide(notification:)),
			name: UIResponder.keyboardWillHideNotification,
			object: nil)
		mainView.findButton.addTarget(self, action: #selector(findButtonClicked), for: .touchUpInside)
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		//tapGesture ??? ?????? didselect ??? ?????????
			navigationItem.titleView?.endEditing(true)
		}
	
	@objc func findButtonClicked() {
		navigationItem.titleView?.endEditing(true)
		if buttonStatus {
			buttonStatus.toggle()
			viewModel.queue { message, vc in
				if let message = message {
					self.buttonStatus = true
					self.view.makeToast(message, duration: 1.0)
				}
				
				if let vc = vc {
					DispatchQueue.main.asyncAfter(deadline: .now()+1) {
						switch viewcon(rawValue: vc)! {
						case .push:
							UserDefaults.standard.set(queueState.matching.rawValue, forKey: UserDefaultsKey.queueStatus.rawValue)
							self.buttonStatus = true
							let vc = FindSeSacTabViewController()
							vc.viewModel.region = self.viewModel.region
							vc.viewModel.lat = self.viewModel.lat
							vc.viewModel.long = self.viewModel.long
							self.pushViewCon(vc: FindSeSacTabViewController())
						case .setting:
							self.buttonStatus = true
							self.pushViewCon(vc: MyInfoManageViewController())
						}
					}
				}
			}
		}
	}
	
	@objc func myHobbyCellClosedButtonClicked(_ sender: UIButton) {
		viewModel.myHobbyArray.value.remove(at: sender.tag)
		mainView.collectionView.reloadData()
	}
	
	@objc func keyboardShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			let keyboardHeight = keyboardSize.height - view.safeAreaInsets.bottom
			mainView.findButton.layer.cornerRadius = 0
			mainView.findButton.snp.updateConstraints {
				$0.bottom.equalTo(view.safeAreaLayoutGuide).inset(keyboardHeight)
				$0.leading.trailing.equalToSuperview()
			}
			mainView.layoutIfNeeded()
		}
	}
	
	@objc func keyboardHide(notification: NSNotification) {
		mainView.findButton.layer.cornerRadius = 8
		mainView.findButton.snp.updateConstraints {
			$0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
			$0.leading.trailing.equalToSuperview().inset(16)
		}
		mainView.layoutIfNeeded()
	}

}

extension HobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if section == 0 {
			return viewModel.recommendArray.count + viewModel.hfArray.value.count
		} else {
			return viewModel.myHobbyArray.value.count
		}
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if indexPath.section == 0 {
			let row = indexPath.row
			if row >= 0 && row < viewModel.recommendArray.count {
				guard let recommendCell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: HobbyRecommendCell.reuseIdentfier, for: indexPath) as? HobbyRecommendCell else { return UICollectionViewCell() }
				recommendCell.textLabel.text = viewModel.recommendArray[row]
				return recommendCell
			} else {
				guard let hfCell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: HobbyHfCell.reuseIdentfier, for: indexPath) as? HobbyHfCell else { return UICollectionViewCell() }
				let index = row - (viewModel.recommendArray.count)
				hfCell.textLabel.text = viewModel.hfArray.value[index]
				return hfCell
			}
		} else {
			guard let myHobbyCell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: HobbyClientCell.reuseIdentfier, for: indexPath) as? HobbyClientCell else { return UICollectionViewCell() }
			let row = indexPath.row
			myHobbyCell.textLabel.text = viewModel.myHobbyArray.value[row]
			myHobbyCell.closeButton.addTarget(self, action: #selector(myHobbyCellClosedButtonClicked(_:)), for: .touchUpInside)
			myHobbyCell.closeButton.tag = row
			return myHobbyCell
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		if indexPath.section == 0 {
			let row = indexPath.row
			if row >= 0 && row < viewModel.recommendArray.count {
				let recommendCell: UILabel = {
					let lb = UILabel()
					lb.font = SesacFont.title4R14.font
					lb.text = viewModel.recommendArray[row]
					lb.sizeToFit()
					return lb
				}()
				let size = recommendCell.frame.size
				return CGSize(width: size.width + 32, height: size.height + 10)
			} else {
				let index = row - (viewModel.recommendArray.count)
				let hfCell: UILabel = {
					let lb = UILabel()
					lb.font = SesacFont.title4R14.font
					lb.text = viewModel.hfArray.value[index]
					lb.sizeToFit()
					return lb
				}()
				let size = hfCell.frame.size
				return CGSize(width: size.width + 32, height: size.height + 10)
			}
		} else {
			let row = indexPath.row
			let myHobbyCell: UILabel = {
				let lb = UILabel()
				lb.font = SesacFont.title4R14.font
				lb.text = viewModel.myHobbyArray.value[row]
				lb.sizeToFit()
				return lb
			}()
			let size = myHobbyCell.frame.size
			return CGSize(width: size.width + 52, height: size.height + 10)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if indexPath.section == 0 {
			let row = indexPath.row
			if row >= 0 && row < viewModel.recommendArray.count {
				viewModel.checkOverlap(value: viewModel.recommendArray[row]) { message in
					guard let message = message else {
						viewModel.myHobbyArray.value.append(viewModel.recommendArray[row])
						return
					}
					self.view.makeToast(message)
				}
			} else {
				let index = row - viewModel.recommendArray.count
				viewModel.checkOverlap(value: viewModel.hfArray.value[index]) { message in
					guard let message = message else {
						viewModel.myHobbyArray.value.append(viewModel.hfArray.value[index])
						return
					}
					self.view.makeToast(message)
				}
			}
		}
		mainView.collectionView.reloadData()
	}
	
	//collectionHeaderView
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		switch kind {
		case UICollectionView.elementKindSectionHeader:
			if indexPath.section == 0 {
				guard let header = mainView.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.identifier, for: indexPath) as? CollectionHeaderView else { return UICollectionReusableView() }
				header.headerLabel.text = "?????? ????????????"
				return header
			} else {
				guard let header = mainView.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.identifier, for: indexPath) as? CollectionHeaderView else { return UICollectionReusableView() }
				header.headerLabel.text = "?????? ?????? ??????"
				return header
			}
			
		default:
			assert(false)
		}
	}

}

extension HobbyViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		navigationItem.titleView?.endEditing(true)
		standByArray.forEach { hobby in
			viewModel.checkOverlap(value: hobby) { message in
				if let message = message {
					view.makeToast(message)
				} else {
					if viewModel.valid(pattern: validPattern.addHobby.rawValue, input: hobby) {
						viewModel.myHobbyArray.value.append(hobby)
					} else {
						view.makeToast("?????? ??? ??? ??????, ?????? 8???????????? ?????? ???????????????")
					}
					
				}
			}
		}
		mainView.collectionView.reloadData()
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		mainView.searchBar.text = ""
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		standByArray = searchText.components(separatedBy: " ")
		print(standByArray)
	}
}

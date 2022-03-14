//
//  BackgroundShopViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/03/05.
//

import UIKit
import SnapKit

class BackgroundShopViewController: UIViewController {
	
	let tableView = UITableView()
	let viewModel = ShopViewModel.shared
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
		setUpConstraint()
		setUpTableView()
	}
	
	func setUpConstraint() {
		view.addSubview(tableView)
		tableView.snp.makeConstraints {
			$0.top.equalTo(view.safeAreaLayoutGuide).offset(253)
			$0.leading.trailing.equalToSuperview()
			$0.bottom.equalTo(view.safeAreaLayoutGuide)
		}
	}
	
	func setUpTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(BackgroundCell.self, forCellReuseIdentifier: BackgroundCell.reuseIdentfier)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = UITableView.automaticDimension
		tableView.separatorStyle = .none
	}
	
	@objc func purchaseButton(_ sender: UIButton) {
		print(sender.tag)
	}

}

extension BackgroundShopViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: BackgroundCell.reuseIdentfier, for: indexPath) as? BackgroundCell else { return UITableViewCell() }
		let row = indexPath.row
		cell.titleLable.text = viewModel.backgroundImageTitle[row]
		cell.subTitleLabel.text = viewModel.backgroundImageSubtitle[row]
		cell.imageViwe.image = backgroundImageEnum(rawValue: row)?.image
		cell.purchaseButton.tag = row
		if viewModel.backgroundPurchaseList.contains(row) {
			cell.purchaseButton.setUpButtonType(type: .purchase)
		}
		cell.purchaseButton.addTarget(self, action: #selector(purchaseButton(_:)), for: .touchUpInside)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.presentBackgroundImage.value = indexPath.row
	}
	
	
}

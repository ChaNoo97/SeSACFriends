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

}

extension BackgroundShopViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: BackgroundCell.reuseIdentfier) as? BackgroundCell else { return UITableViewCell() }
		
		return cell
	}
	
	
	
}

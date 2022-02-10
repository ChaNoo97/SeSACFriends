//
//  HomeView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/27.
//

import UIKit
import SnapKit
import MapKit

final class HomeView: UIView, ViewProtocols {
	
	let mapView = MKMapView()
	let centerPin = UIImageView()
	let manButton = UIButton()
	let manLabel = UILabel()
	let womanButton = UIButton()
	let womanLabel = UILabel()
	let allButton = UIButton()
	let allLabel = UILabel()
	let stackView = UIStackView()
	let gpsButton = UIButton()
	let matchingButton = UIButton()

	override init(frame: CGRect) {
		super.init(frame: frame)
		stackViewConfigure()
		setupConstraint()
		configure()
		setUpShadow()
		allButton.tag = 0
		manButton.tag = 1
		womanButton.tag = 2
	}
	
	func setUpShadow() {
		[stackView, gpsButton].forEach {
			$0.layer.shadowOffset = CGSize(width: 1, height: 3)
			$0.layer.shadowOpacity = 0.3
			$0.layer.shadowColor = UIColor.black.cgColor
			$0.layer.shadowRadius = 3
		}
		allButton.layer.cornerRadius = 8
		allButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		womanButton.layer.cornerRadius = 8
		womanButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
		
	}
	
	func stackViewConfigure() {
		stackView.axis = .vertical
		stackView.distribution = .fillEqually
		stackView.layer.cornerRadius = 8
	}
	
	func configure() {
		
		gpsButton.setImage(UIImage(named: "gps"), for: .normal)
		gpsButton.layer.cornerRadius = 8
		
		[allButton, manButton, womanButton, gpsButton].forEach {
			$0.backgroundColor = .sesacWhite
		}
		
		centerPin.image = UIImage(named: "centerPin")
		matchingButton.setImage(UIImage(named: "default"), for: .normal)
		matchingButton.layer.cornerRadius = 32
		matchingButton.clipsToBounds = true
		
		mapView.isRotateEnabled = false
		mapView.isPitchEnabled = false
		
		setUpButtonTitle()
	}
	
	func setupConstraint() {
		addSubview(mapView)
		
		[stackView, gpsButton, matchingButton, centerPin].forEach {
			mapView.addSubview($0)
		}
		
		[allButton, manButton, womanButton].forEach {
			stackView.addArrangedSubview($0)
		}
		
		mapView.snp.makeConstraints {
			$0.top.equalToSuperview()
			$0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
		}
		
		centerPin.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.size.equalTo(48)
		}
		
		stackView.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(16)
			$0.top.equalToSuperview().inset(52)
			$0.width.equalTo(48)
			$0.height.equalTo(144)
		}
		
		
		gpsButton.snp.makeConstraints {
			$0.leading.equalToSuperview().inset(16)
			$0.top.equalToSuperview().inset(212)
			$0.size.equalTo(48)
		}
		
		matchingButton.snp.makeConstraints {
			$0.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
			$0.size.equalTo(64)
		}
		
	}
	
	func setUpButtonTitle() {
		allButton.addSubview(allLabel)
		manButton.addSubview(manLabel)
		womanButton.addSubview(womanLabel)
		
		allLabel.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.height.equalTo(22)
		}
		
		manLabel.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.height.equalTo(22)
		}
		
		womanLabel.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.height.equalTo(22)
		}
		setupLabel(label: allLabel, font: .title4R14, text: "전체")
		setupLabel(label: manLabel, font: .title4R14, text: "남자")
		setupLabel(label: womanLabel, font: .title4R14, text: "여자")
	}
	
	func changeGenderButton(button: UIButton, label: UILabel ,type: GenderButtonType) {
		switch type {
		case .select:
			button.backgroundColor = .sesacGreen
			label.font = SesacFont.title3M14.font
			label.textColor = .sesacWhite
		case .unSelect:
			button.backgroundColor = .sesacWhite
			label.font = SesacFont.title4R14.font
			label.textColor = .black
		}
	}
	
	func selectAllButton() {
		changeGenderButton(button: allButton, label: allLabel, type: .select)
		changeGenderButton(button: manButton, label: manLabel, type: .unSelect)
		changeGenderButton(button: womanButton, label: womanLabel, type: .unSelect)
	}
	
	func selectManButton() {
		changeGenderButton(button: allButton, label: allLabel, type: .unSelect)
		changeGenderButton(button: manButton, label: manLabel, type: .select)
		changeGenderButton(button: womanButton, label: womanLabel, type: .unSelect)
	}
	
	func selectWomanButton() {
		changeGenderButton(button: womanButton, label: womanLabel, type: .select)
		changeGenderButton(button: manButton, label: manLabel, type: .unSelect)
		changeGenderButton(button: allButton, label: allLabel, type: .unSelect)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

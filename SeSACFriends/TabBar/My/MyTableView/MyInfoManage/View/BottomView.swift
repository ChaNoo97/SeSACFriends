//
//  BottomView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/03.
//

import UIKit
import SnapKit
import MultiSlider

final class BottomView: UIView {
	
	let myGenderView = UIView()
	let myGenderViewTitle = UILabel()
	let manButton = GenderButton(frame: .zero, type: .unSelect)
	let manButtonTitleLabel = UILabel()
	let womanButton = GenderButton(frame: .zero, type: .unSelect)
	let womanButtonTitleLabel = UILabel()
	let myHobbyView = UIView()
	let myHobbyViewTitle = UILabel()
	let hobbyTextField = MainTextField(frame: .zero, type: .inactive)
	let myPhoneNumberSearchActiveView = UIView()
	let myPhoneNumberSearchActiveViewTitle = UILabel()
	let activeSwitch = UISwitch()
	let otherAgeSearchRangeView = UIView()
	let otherAgeSearchRangeViewTitle = UILabel()
	let otherAgeNumberLabel = UILabel()
	let otherAgeSliderView = UIView()
	let slider = MultiSlider()
	let withdrawButton = UIButton()
	let withdrawViewTitle = UILabel()
	let stackView = UIStackView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConstraint()
		stackViewSetUp()
		subViewConstraint()
		subViewConfigure()
		sliderSetting()
	}
	
	func sliderSetting() {
		slider.orientation = .horizontal
		slider.thumbImage = UIImage(named: "thumb")
		slider.outerTrackColor = .sesacGray2
		slider.trackWidth = 4
		slider.tintColor = .sesacGreen
		slider.snapStepSize = 1
		slider.distanceBetweenThumbs = 1
		slider.hasRoundTrackEnds = true
		slider.minimumValue = 18
		slider.maximumValue = 65
	}
	
	func subViewConfigure() {
		manButton.setupLabel(label: manButtonTitleLabel, font: SesacFont.body3R14, text: "남자")
		womanButton.setupLabel(label: womanButtonTitleLabel, font: SesacFont.body3R14, text: "여자")
		myGenderViewTitle.text = "내 성별"
		myHobbyViewTitle.text = "자주 하는 취미"
		hobbyTextField.textField.placeholder = "취미를 입력해 주세요"
		myPhoneNumberSearchActiveViewTitle.text = "내 번호 검색 허용"
		otherAgeSearchRangeViewTitle.text = "상대방 연령대"
		otherAgeNumberLabel.font = SesacFont.title3M14.font
		otherAgeNumberLabel.textColor = .sesacGreen
		withdrawViewTitle.text = "회원 탈퇴"
	}
	
	func subViewConstraint() {
		[myGenderViewTitle, manButton, womanButton].forEach {
			myGenderView.addSubview($0)
		}
		
		manButton.addSubview(manButtonTitleLabel)
		womanButton.addSubview(womanButtonTitleLabel)
		
		myGenderViewTitle.snp.makeConstraints {
			$0.leading.equalTo(myGenderView)
			$0.top.bottom.equalTo(myGenderView).inset(13)
		}
		
		womanButton.snp.makeConstraints {
			$0.trailing.top.bottom.equalTo(myGenderView)
			$0.width.equalTo(56)
		}
		
		womanButtonTitleLabel.snp.makeConstraints {
			$0.center.equalTo(womanButton)
			$0.height.equalTo(24)
		}
		manButton.snp.makeConstraints {
			$0.width.equalTo(56)
			$0.trailing.equalTo(womanButton.snp.leading).offset(-8)
			$0.top.bottom.equalTo(myGenderView)
		}
		
		manButtonTitleLabel.snp.makeConstraints {
			$0.center.equalTo(manButton)
			$0.height.equalTo(24)
		}
		
		[myHobbyViewTitle, hobbyTextField].forEach {
			myHobbyView.addSubview($0)
		}
		
		myHobbyViewTitle.snp.makeConstraints {
			$0.leading.equalTo(myHobbyView)
			$0.top.bottom.equalTo(myHobbyView).inset(13)
		}
		
		hobbyTextField.snp.makeConstraints {
			$0.width.equalTo(164)
			$0.top.trailing.bottom.equalTo(myHobbyView)
		}
		
		[myPhoneNumberSearchActiveViewTitle, activeSwitch].forEach {
			myPhoneNumberSearchActiveView.addSubview($0)
		}
		
		myPhoneNumberSearchActiveViewTitle.snp.makeConstraints {
			$0.leading.equalTo(myPhoneNumberSearchActiveView)
			$0.top.bottom.equalTo(myPhoneNumberSearchActiveView).inset(13)
		}
		
		activeSwitch.snp.makeConstraints {
			$0.trailing.equalTo(myPhoneNumberSearchActiveView)
			$0.top.bottom.equalTo(myPhoneNumberSearchActiveView).inset(10)
		}
		
		[otherAgeSearchRangeViewTitle, otherAgeNumberLabel, otherAgeSliderView].forEach {
			otherAgeSearchRangeView.addSubview($0)
		}
		
		otherAgeSearchRangeViewTitle.snp.makeConstraints {
			$0.leading.equalTo(otherAgeSearchRangeView)
			$0.top.equalTo(otherAgeSearchRangeView).inset(13)
		}
		
		otherAgeNumberLabel.snp.makeConstraints {
			$0.trailing.equalTo(otherAgeSearchRangeView)
			$0.top.equalTo(otherAgeSearchRangeView).inset(13)
		}
		
		otherAgeSliderView.snp.makeConstraints {
			$0.top.equalTo(otherAgeSearchRangeViewTitle.snp.bottom).offset(13)
			$0.leading.trailing.equalTo(otherAgeSearchRangeView)
			$0.bottom.equalTo(otherAgeSearchRangeView.snp.bottom).inset(8)
			$0.height.equalTo(32)
		}
		
		otherAgeSliderView.addSubview(slider)
		slider.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
		
		withdrawButton.addSubview(withdrawViewTitle)
		
		withdrawViewTitle.snp.makeConstraints {
			$0.leading.equalTo(withdrawButton)
			$0.top.bottom.equalTo(withdrawButton).inset(13)
		}
		
	}
	
	
	func setupConstraint() {
		addSubview(stackView)
		[myGenderView, myHobbyView, myPhoneNumberSearchActiveView, otherAgeSearchRangeView ,withdrawButton].forEach {
			stackView.addArrangedSubview($0)
		}
		
		stackView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
		
		myGenderView.snp.makeConstraints {
			$0.height.equalTo(48)
		}
		
		myHobbyView.snp.makeConstraints {
			$0.height.equalTo(48)
		}
		
		myPhoneNumberSearchActiveView.snp.makeConstraints {
			$0.height.equalTo(48)
		}
		
		otherAgeSearchRangeView.snp.makeConstraints {
			$0.height.equalTo(80)
		}
		
		withdrawButton.snp.makeConstraints {
			$0.height.equalTo(48)
		}
		
		
	}
	
	func stackViewSetUp() {
		stackView.axis = .vertical
	 	stackView.distribution = .fill
		stackView.spacing = 16
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

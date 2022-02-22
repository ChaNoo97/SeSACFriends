//
//  SesacImageEnum.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/09.
//

import Foundation
import UIKit

enum sesacImageStyle: String {
	case face1
	case face2
	case face3
	case face4
	case face5
}

enum genderEnum: Int {
	case all = 0
	case man = 1
	case woman = 2
}

enum viewcon: Int {
	case push = 0
	case setting = 1
}

enum backgroundImageEnum: Int {
	case back1 = 0
	case back2 = 1
	case back3 = 2
	case back4 = 3
	case back5 = 4
}

enum sesacImageEnum: Int {
	case face1 = 0
	case face2 = 1
	case face3 = 2
	case face4 = 3
	case face5 = 4
}

extension backgroundImageEnum {
	var image: UIImage {
		switch self {
		case .back1:
			return .makeImage(name: "back1")
		case .back2:
			return .makeImage(name: "back2")
		case .back3:
			return .makeImage(name: "back3")
		case .back4:
			return .makeImage(name: "back4")
		case .back5:
			return .makeImage(name: "back5")
		}
	}
}

extension sesacImageEnum {
	var image: UIImage {
		switch self {
		case .face1:
			return .makeImage(name: "face1")
		case .face2:
			return .makeImage(name: "face2")
		case .face3:
			return .makeImage(name: "face3")
		case .face4:
			return .makeImage(name: "face4")
		case .face5:
			return .makeImage(name: "face5")
		}
	}
}

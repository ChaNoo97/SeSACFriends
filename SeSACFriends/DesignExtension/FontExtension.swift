//
//  FontExtension.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/18.
//

import Foundation
import UIKit

public enum SesacFont {
	case display1R20
	case title1M16
	case title2R16
	case title3M14
	case title4R14
	case title5M12
	case title5R12
	case body1M16
	case body2R16
	case body3R14
	case body4R12
	case captionR10
}

extension SesacFont {
	var font: UIFont {
		switch self {
		case .display1R20:
			return .makeSesacFont(name: "R", size: 20)
		case .title1M16:
			return .makeSesacFont(name: "M", size: 16)
		case .title2R16:
			return .makeSesacFont(name: "R", size: 16)
		case .title3M14:
			return .makeSesacFont(name: "M", size: 14)
		case .title4R14:
			return .makeSesacFont(name: "R", size: 14)
		case .title5M12:
			return .makeSesacFont(name: "M", size: 12)
		case .title5R12:
			return .makeSesacFont(name: "R", size: 12)
		case .body1M16:
			return .makeSesacFont(name: "M", size: 16)
		case .body2R16:
			return .makeSesacFont(name: "R", size: 16)
		case .body3R14:
			return .makeSesacFont(name: "R", size: 14)
		case .body4R12:
			return .makeSesacFont(name: "R", size: 12)
		case .captionR10:
			return .makeSesacFont(name: "R", size: 10)
		}
	}
}

extension UIFont {
	static func makeSesacFont(name n: String, size s: CGFloat) -> UIFont {
		if n == "R" {
			return UIFont(name: "NotoSansCJKkr-Regular",size: s)!
		} else {
			return UIFont(name: "NotoSansCJKkr-Medium", size: s)!
		}
	}
}

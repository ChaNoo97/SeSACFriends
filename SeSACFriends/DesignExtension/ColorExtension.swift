//
//  DesignHelper.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/18.
//

import Foundation
import UIKit

extension UIColor {
	
	static func makeColor(R red: CGFloat, G green: CGFloat, B blue: CGFloat, a alpha: CGFloat ) -> UIColor {
		return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
	}
	
	//MARK: White & Black
	static let sesacWhite = makeColor(R: 255, G: 255, B: 255, a: 1)
	static let sesacBlack = makeColor(R: 51, G: 51, B: 51, a: 1)
	
	//MARK: BrandColor
	static let sesacGreen = makeColor(R: 73, G: 220, B: 146, a: 1)
	static let sesacWhitegreen = makeColor(R: 205, G: 244, B: 255, a: 1)
	static let sesacYellogreen = makeColor(R: 178, G: 235, B: 97, a: 1)
	
	//MARK: GrayScale
	static let sesacGray1 = makeColor(R: 247, G: 247, B: 247, a: 1)
	static let sesacGray2 = makeColor(R: 239, G: 239, B: 239, a: 1)
	static let sesacGray3 = makeColor(R: 226, G: 226, B: 226, a: 1)
	static let sesacGray4 = makeColor(R: 209, G: 209, B: 209, a: 1)
	static let sesacGray5 = makeColor(R: 189, G: 189, B: 189, a: 1)
	static let sesacGray6 = makeColor(R: 170, G: 170, B: 170, a: 1)
	static let sesacGray7 = makeColor(R: 126, G: 126, B: 126, a: 1)
	
	//MARK: SystemColor
	static let sesacSuccess = makeColor(R: 98, G: 143, B: 229, a: 1)
	static let sesacError = makeColor(R: 233, G: 102, B: 107, a: 1)
	static let sesacFocus = sesacBlack
}

//
//  CustomAnnotationView.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/02/09.
//

import Foundation
import MapKit

final class CustomAnnotationView: MKAnnotationView {
	static let identifier = "CustomAnnotationView"
	
	override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
		frame = CGRect(x: 0, y: 0, width: 40, height: 50)
	}
	
	private func setupUI() {
		backgroundColor = .clear
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

final class CustomAnnotation: NSObject, MKAnnotation {
	let style: sesacImageStyle
	let coordinate: CLLocationCoordinate2D
	
	init(style: sesacImageStyle, coordinate: CLLocationCoordinate2D) {
		self.style = style
		self.coordinate = coordinate
		super.init()
	}
	
	
}

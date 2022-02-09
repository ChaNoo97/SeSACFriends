//
//  HomeViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/27.
//

import UIKit
import SnapKit
import MapKit

final class HomeViewController: BaseViewController {
	
	let locationManager = CLLocationManager()
	let mainView = HomeView()
	
	var myLocation: CLLocationCoordinate2D?

	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.navigationBar.isHidden = true
		self.navigationController?.navigationBar.isTranslucent = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		checkUserLocationServicesAuthorization()
		mainView.mapView.delegate = self
		locationManager.delegate = self
		
		mainView.allButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
		mainView.manButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
		mainView.womanButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
		mainView.gpsButton.addTarget(self, action: #selector(gpsButtonClicked), for: .touchUpInside)
	}
	
	@objc func gpsButtonClicked() {
		print("dd")
		checkUserLocationServicesAuthorization()
		if let myLocation = myLocation {
			mainView.mapView.setRegion(MKCoordinateRegion(center: myLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
			addCustomPin()
		}
		
	}
	
	@objc func buttonClicked(_ sender: UIButton) {
		switch sender.tag {
			//enum
		case 0:
			mainView.selectAllButton()
		case 1:
			mainView.selectManButton()
		case 2:
			mainView.selectWomanButton()
		default:
			break
		}
	}
	
}

extension HomeViewController: MKMapViewDelegate, CLLocationManagerDelegate {
	
	func checkCurrentLocationAuthorization(authorizationStatus: CLAuthorizationStatus) {
		
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		
		switch authorizationStatus {
		case .notDetermined:
			locationManager.requestWhenInUseAuthorization()
			locationManager.startUpdatingLocation()
		case .denied, .restricted:
			print("denided")
			changeAuthAlert()
		case .authorizedAlways:
			locationManager.startUpdatingLocation()
		case .authorizedWhenInUse:
			print("wheninuse")
			locationManager.startUpdatingLocation()
		@unknown default:
			print("unknown")
		}
		
	}
	
	func changeAuthAlert() {
		
		let alert = UIAlertController(title: "위치권한 요청", message: "친구 찾기를 위해 위치권한이 필요합니다.", preferredStyle: .alert)
		let settingAction = UIAlertAction(title: "설정", style: .default) { action in
			guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
			if UIApplication.shared.canOpenURL(url) {
				UIApplication.shared.open(url)
			}
		}
		let cancelAction = UIAlertAction(title: "취소", style: .cancel) { UIAlertAction in
			
		}
		
		alert.addAction(settingAction)
		alert.addAction(cancelAction)
		
		present(alert, animated: true, completion: nil)
	}
	
	func checkUserLocationServicesAuthorization() {
		let authorizationStatus: CLAuthorizationStatus
		if #available(iOS 14, *) {
			authorizationStatus = locationManager.authorizationStatus
		} else {
			authorizationStatus = CLLocationManager.authorizationStatus()
		}
		
		if CLLocationManager.locationServicesEnabled() {
			checkCurrentLocationAuthorization(authorizationStatus: authorizationStatus)
		}
	}
	
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		print("change")
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		myLocation = CLLocationCoordinate2D(latitude: locations.last!.coordinate.latitude, longitude: locations.last!.coordinate.longitude)
	}
	
	func addCustomPin() {
		let pin = MKPointAnnotation()
		pin.coordinate = CLLocationCoordinate2D(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude)
		mainView.mapView.addAnnotation(pin)
	}
	
}

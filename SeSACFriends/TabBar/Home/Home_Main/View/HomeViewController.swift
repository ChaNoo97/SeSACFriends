//
//  HomeViewController.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/27.
//

import UIKit
import MapKit
import SnapKit
import Toast

final class HomeViewController: BaseViewController {
	
	let locationManager = CLLocationManager()
	let mainView = HomeView()
	let viewModel = HomeViewModel()
	
	var myLocation: CLLocationCoordinate2D?
	var centerLocation: CLLocationCoordinate2D?
	let sesacLocation = CLLocationCoordinate2D(latitude: 37.517819364682694, longitude: 126.88647317074734)
	var setRegionOnce = true
	
	var userAnnotationArray: [CustomAnnotation] = []
	
	override func loadView() {
		self.view = mainView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarDisplay()
		navBarHidden()
		if let queueStatus = UserDefaults.standard.string(forKey: UserDefaultsKey.queueStatus.rawValue) {
			print("******image*******Homevc36",queueStatus)
			floatingButtonSetImage(imageName: queueStatus)
		} else {
			floatingButtonSetImage(imageName: "normal")
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		checkUserLocationServicesAuthorization()
		mainView.mapView.delegate = self
		locationManager.delegate = self
		mainView.mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: CustomAnnotationView.identifier)
		mainView.allButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
		mainView.manButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
		mainView.womanButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
		mainView.gpsButton.addTarget(self, action: #selector(gpsButtonClicked), for: .touchUpInside)
		mainView.matchingButton.addTarget(self, action: #selector(matchingButtonClicked), for: .touchUpInside)
		mainView.selectAllButton()
	}
	
	func valueDeliver(_ vc: HobbyViewController) {
		vc.viewModel.recommendArray = self.viewModel.recommendArray
		vc.viewModel.hfArray.value = self.viewModel.hfArray
		vc.viewModel.region = self.viewModel.region.value
		vc.viewModel.lat = self.viewModel.lat.value
		vc.viewModel.long = self.viewModel.long.value
	}
	
	func valueDeliver(vc: FindSeSacTabViewController) {
		vc.viewModel.region = self.viewModel.region.value
		vc.viewModel.lat = self.viewModel.lat.value
		vc.viewModel.long = self.viewModel.long.value
	}
	
	func floatingButtonSetImage(imageName: String) {
		mainView.matchingButton.setImage(UIImage(named: imageName), for: .normal)
	}
	
	@objc func buttonClicked(_ sender: UIButton) {
		viewModel.selectGender.value = sender.tag
		switch genderEnum(rawValue: sender.tag)! {
		case .all:
			mainView.selectAllButton()
			UserDefaults.standard.set(2, forKey: UserDefaultsKey.genderStstus.rawValue)
		case .man:
			mainView.selectManButton()
			UserDefaults.standard.set(1, forKey: UserDefaultsKey.genderStstus.rawValue)
		case .woman:
			mainView.selectWomanButton()
			UserDefaults.standard.set(0, forKey: UserDefaultsKey.genderStstus.rawValue)
		}
	}
	
	@objc func gpsButtonClicked() {
		checkUserLocationServicesAuthorization()
		mainView.mapView.showsUserLocation = true
		mainView.mapView.setUserTrackingMode(.follow, animated: true)
		if let myLocation = myLocation {
			mainView.mapView.setRegion(MKCoordinateRegion(center: myLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
		}
		
	}
	
	@objc func matchingButtonClicked() {
		checkUserLocationServicesAuthorization()
		if let queueStatus = UserDefaults.standard.string(forKey: UserDefaultsKey.queueStatus.rawValue) {
			if queueStatus == "normal" {
				let vc = HobbyViewController()
				valueDeliver(vc)
				pushViewCon(vc: vc)
			}  else if queueStatus == "matching" {
				let vc1 = HobbyViewController()
				let vc2 = FindSeSacTabViewController()
				valueDeliver(vc: vc2)
				self.navigationController?.pushViewController(vc1, animated: false)
				self.navigationController?.pushViewController(vc2, animated: true)
			} else if queueStatus == "matched" {
				
				pushViewCon(vc: ChattingViewController())
			}
		} else {
			let vc = HobbyViewController()
			valueDeliver(vc)
			pushViewCon(vc: vc)
		}
	}
	
}

extension HomeViewController: MKMapViewDelegate {
	
	func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
		self.centerLocation = self.mainView.mapView.centerCoordinate
		if let centerLocation = centerLocation {
			viewModel.lat.value = centerLocation.latitude
			viewModel.long.value = centerLocation.longitude
			viewModel.region.value = viewModel.operationRegion(lat: centerLocation.latitude, long: centerLocation.longitude)
			
			viewModel.onQueue { message in
				if let message = message {
					self.view.makeToast(message)
				}
				
				//???????????? ??????
				self.viewModel.selectGender.bind { gender in
					self.mainView.mapView.removeAnnotations(self.userAnnotationArray)
					self.userAnnotationArray.removeAll()
					switch genderEnum(rawValue: gender)! {
					case .all:
						self.viewModel.allUser.forEach({ user in
							self.addCustomPin(style: user.sesac, coordinate: CLLocationCoordinate2D(latitude: user.lat, longitude: user.long))
						})
					case .man:
						self.viewModel.manUser.forEach({ user in
							self.addCustomPin(style: user.sesac, coordinate: CLLocationCoordinate2D(latitude: user.lat, longitude: user.long))
						})
					case .woman:
						self.viewModel.womanUSer.forEach({ user in
							self.addCustomPin(style: user.sesac, coordinate: CLLocationCoordinate2D(latitude: user.lat, longitude: user.long))
						})
					}
				}
			}
		}
		
	}
	
	func addCustomPin(style: Int,  coordinate: CLLocationCoordinate2D) {
		let pin = CustomAnnotation(style: viewModel.setUpSesacStyle(style), coordinate: coordinate)
		userAnnotationArray.append(pin)
		self.userAnnotationArray.forEach {
			self.mainView.mapView.addAnnotation($0)
		}
	}
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		guard let annotation = annotation as? CustomAnnotation else {
			return nil
		}
		
		var annotationView = self.mainView.mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
		
		if annotationView == nil {
			annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
			annotationView?.canShowCallout = false
			annotationView?.contentMode = .scaleAspectFit
		} else {
			annotationView?.annotation = annotation
		}
		
		let sesacImage: UIImage!
		let size = CGSize(width: 85, height: 85)
		UIGraphicsBeginImageContext(size)
		
		switch annotation.style {
		case .face1:
			sesacImage = UIImage(named: sesacImageStyle.face1.rawValue)
		case .face2:
			sesacImage = UIImage(named: sesacImageStyle.face2.rawValue)
		case .face3:
			sesacImage = UIImage(named: sesacImageStyle.face3.rawValue)
		case .face4:
			sesacImage = UIImage(named: sesacImageStyle.face4.rawValue)
		case .face5:
			sesacImage = UIImage(named: sesacImageStyle.face5.rawValue)
		}
	
		sesacImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
		let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
		annotationView?.image = resizedImage
		
		return annotationView
	}
}

extension HomeViewController: CLLocationManagerDelegate {
	
	func checkCurrentLocationAuthorization(authorizationStatus: CLAuthorizationStatus) {
		print("CheckCurrentLocation")
		
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		
		switch authorizationStatus {
		case .notDetermined:
			locationManager.requestWhenInUseAuthorization()
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
		mainView.mapView.setRegion(MKCoordinateRegion(center: sesacLocation, latitudinalMeters: 700, longitudinalMeters: 700), animated: true)
		let alert = UIAlertController(title: "???????????? ??????", message: "?????? ????????? ?????? ??????????????? ???????????????.", preferredStyle: .alert)
		let settingAction = UIAlertAction(title: "??????", style: .default) { action in
			guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
			if UIApplication.shared.canOpenURL(url) {
				UIApplication.shared.open(url)
			}
		}
		let cancelAction = UIAlertAction(title: "??????", style: .cancel) { UIAlertAction in
			
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
		checkUserLocationServicesAuthorization()
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		myLocation = CLLocationCoordinate2D(latitude: locations.last!.coordinate.latitude, longitude: locations.last!.coordinate.longitude)
		mainView.mapView.showsUserLocation = true
		if let myLocation = myLocation {
			if setRegionOnce {
				setRegionOnce.toggle()
				mainView.mapView.setRegion(MKCoordinateRegion(center: myLocation, latitudinalMeters: 700, longitudinalMeters: 700), animated: true)
			}
		}
		locationManager.stopUpdatingLocation()
	}
	
}

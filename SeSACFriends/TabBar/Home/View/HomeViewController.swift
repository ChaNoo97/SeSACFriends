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
		mainView.mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: CustomAnnotationView.identifier)
		mainView.allButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
		mainView.manButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
		mainView.womanButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
		mainView.gpsButton.addTarget(self, action: #selector(gpsButtonClicked), for: .touchUpInside)
		if let myLocation = myLocation {
			mainView.mapView.showsUserLocation = true
			mainView.mapView.setRegion(MKCoordinateRegion(center: myLocation, latitudinalMeters: 700, longitudinalMeters: 700), animated: true)
		} else {
			mainView.mapView.showsUserLocation = true
			mainView.mapView.setRegion(MKCoordinateRegion(center: sesacLocation, latitudinalMeters: 700, longitudinalMeters: 700), animated: true)
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

extension HomeViewController: MKMapViewDelegate {
	
	func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
		self.centerLocation = self.mainView.mapView.centerCoordinate
		if let centerLocation = centerLocation {
			print(centerLocation)
			viewModel.lat.value = centerLocation.latitude
			viewModel.long.value = centerLocation.longitude
			viewModel.region.value = viewModel.operationRegion(lat: centerLocation.latitude, long: centerLocation.longitude)
			viewModel.onQueue { message in
				guard let message = message else {
					return
				}
				self.view.makeToast(message)
				let count = self.viewModel.userLocation.value.count
				for i in 0...count-1 {
					self.addCustomPin(style: .face5, coordinate: CLLocationCoordinate2D(latitude: self.viewModel.userLocation.value[i][0], longitude: self.viewModel.userLocation.value[i][1]))
				}
			}
		}
	}
	
//	self.addCustomPin(style: .face5, coordinate: CLLocationCoordinate2D(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>))
	
	func addSesacPin(lat: Double, long: Double) {
		
	}
	
	func addCustomPin(style: sesacImageStyle,  coordinate: CLLocationCoordinate2D) {
		let pin = CustomAnnotation(style: style, coordinate: coordinate)
		mainView.mapView.addAnnotation(pin)
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

extension HomeViewController:  CLLocationManagerDelegate {
	
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
		checkUserLocationServicesAuthorization()
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		myLocation = CLLocationCoordinate2D(latitude: locations.last!.coordinate.latitude, longitude: locations.last!.coordinate.longitude)
		mainView.mapView.showsUserLocation = true
	}
	
	
	
}

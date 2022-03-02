//
//  AppDelegate.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/01/18.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		NetworkMonitor.shared.startMonitoring {
			

		}

		FirebaseApp.configure()
		
		if #available(iOS 10.0, *) {
			UNUserNotificationCenter.current().delegate = self
			
			let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
			UNUserNotificationCenter.current().requestAuthorization(
				options: authOptions,
				completionHandler: {_, _ in })
		} else {
			let settings: UIUserNotificationSettings = UIUserNotificationSettings(
				types: [.alert, .sound, .badge],
				categories: nil)
			application.registerUserNotificationSettings(settings)
		}
		application.registerForRemoteNotifications()
		Messaging.messaging().delegate = self
		Messaging.messaging().token { token, error in
			if let error = error {
				print("Error fetching FCM registration token: \(error)")
			} else if let token = token {
				print("FCM registration token: \(token)")
			}
		}
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}
	
	func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
		return UIInterfaceOrientationMask.portrait
	}


}

extension AppDelegate: UNUserNotificationCenterDelegate {
	
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
			completionHandler([.list, .banner, .badge, .sound])
		}
	
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		Messaging.messaging().apnsToken = deviceToken
	}
}

extension AppDelegate: MessagingDelegate {
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
		UserDefaults.standard.set(fcmToken, forKey: UserDefaultsKey.FCMtoken.rawValue)
		print("Firebase registeration token: \(String(describing: fcmToken))")
		let dataDict: [String: String] = ["token": fcmToken ?? "" ]
		NotificationCenter.default.post(
			name: Notification.Name("FCMToken"),
			object: nil,
			userInfo: dataDict
		)
	}
}

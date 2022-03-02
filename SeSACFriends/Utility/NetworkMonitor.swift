//
//  NetworkMonitor.swift
//  SeSACFriends
//
//  Created by Hoo's MacBookPro on 2022/03/02.
//

import Foundation
import Network

final class NetworkMonitor {
	static let shared = NetworkMonitor()
	
	private let queue = DispatchQueue.global()
	private let monitor: NWPathMonitor
	public private(set) var isConnected: Bool = false
	public private(set) var connectionType: ConnectionType = .unknown
	
	enum ConnectionType {
		case wifi
		case cellular
		case ethernet
		case unknown
	}
	
	private init() {
		print("init 호출")
		monitor = NWPathMonitor()
	}
	
	public func startMonitoring(completion: @escaping() -> Void) {
		print("startMonitoring 호출")
		monitor.start(queue: queue)
		monitor.pathUpdateHandler = { [weak self] path in
			print("path: \(path)")
		
			self?.isConnected = path.status == .satisfied
			self?.getConnectionType(path)
			
			if self?.isConnected == true {
				print("연결이됨")
			} else {
				completion()
			}
		}
	}
	
	public func stopMonitroing() {
		print("stopMonitroint 호출")
		monitor.cancel()
	}
	
	private func getConnectionType(_ path: NWPath) {
		print("getConnectionType 호출")
		if path.usesInterfaceType(.wifi) {
			connectionType = .wifi
			print("wifi 연결")
		} else if path.usesInterfaceType(.cellular) {
			connectionType = .cellular
			print("cellular에 연결")
		} else if path.usesInterfaceType(.wiredEthernet) {
			connectionType = .ethernet
			print("wiredEthernet 에 연결")
		} else {
			connectionType = .unknown
			print("unknown..")
		}
	}
}

//
//  InternetHandler.swift
//  FitTracker
//
//  Created by Rizwan Shaikh on 28/03/24.
//

import Foundation
import Reachability

class InternetHandler{
    
    static let shared = InternetHandler()
    private init(){}
    
    private lazy var reachability:Reachability = {
        let reachability = try! Reachability.init(hostname: "www.google.com")
        return reachability
    }()
    
    private var isInternetAvailable:Bool = false
    
    func checkForInternetConnection() -> Bool {
        return isInternetAvailable
    }
    
    ///Adds internet observer
    func setupReachabilityForInternetConnect() {
        if reachability.connection == .cellular ||  reachability.connection == .wifi{
            isInternetAvailable = true
        }
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(notification:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        }catch {
            print("Exception Reachabilit \(error)")
        }
    }
    
    ///Removes internet observer
    func removeInternetObserver(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func reachabilityChanged(notification: Notification) {
        
        let reachability = notification.object as! Reachability

        switch reachability.connection {
        case .wifi:
            isInternetAvailable = true
            break
        case .cellular:
            isInternetAvailable = true
            break
        case .unavailable:
            isInternetAvailable = false
            break
        case .none:break
        }
    }
    
}

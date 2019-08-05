//
//  OnlineManager.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 8/4/19.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation
import Alamofire

class OnlineManager {
    
    // MARK: - Shared
    
    static let shared = OnlineManager()
    
    // MARK: - Connectivity
    
    func isOnline() -> Bool {
        return !Connectivity.isConnectedToInternet
    }
}

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

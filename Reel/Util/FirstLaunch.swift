//
//  FirstLaunch.swift
//  Reel
//
//  Created by Juan Manuel Moreno on 25/08/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation

final class FirstLaunch {
    
    let userDefaults: UserDefaults = .standard
    
    let wasLaunchedBefore: Bool
    
    var isFirstLaunch: Bool {
        return !wasLaunchedBefore
//        return true
    }
    
    init() {
        let key = "wasLaunchedBefore"
        let wasLaunchedBefore = userDefaults.bool(forKey: key)
        self.wasLaunchedBefore = wasLaunchedBefore
        if !wasLaunchedBefore {
            userDefaults.set(true, forKey: key)
        }
    }
    
}

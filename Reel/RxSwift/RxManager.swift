//
//  RxManager.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 8/4/19.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation

class RxManager {

    // MARK: - Shared
    
    static let shared = RxManager()
    
    // MARK: - Character
    
    var observer: ObserverOnline?
    
    // MARK: - Business
    
    func doObserver (time: Int, summaryViewController: SummaryViewController) {
        self.observer = ObserverOnline()
        self.observer!.time = time
        self.observer?.summaryViewController = summaryViewController
        self.observer!.prepare()
    }
}

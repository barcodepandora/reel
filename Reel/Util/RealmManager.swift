//
//  RealmManager.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 8/3/19.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager: NSObject {
    
    // MARK: - Shared
    
    static let shared = RealmManager()
    
    // MARK: - Character
    
    var realm: Realm?

    // MARK: - Init
    
    override init() {
        super.init()
        self.initCache()
    }

    func initCache() {
        let cachesDirectoryPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        let cachesDirectoryURL = NSURL(fileURLWithPath: cachesDirectoryPath)
        let fileURL = cachesDirectoryURL.appendingPathComponent("Default.realm")
        let config = Realm.Configuration(fileURL: fileURL)
        self.realm = try! Realm(configuration: config)
    }
    
    // MARK: - Realm
    
    func writePopularMoviesArray(_ showArray: [Show]) {
        var collectionShow = CollectionShowPopular()
//        collectionShow.collection = showArray as NSArray
        try! realm!.write {
            realm!.add(collectionShow)
        }
    }
}

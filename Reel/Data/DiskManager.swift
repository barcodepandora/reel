//
//  DiskManager.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 8/4/19.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation
import Disk

class DiskManager: DataManager {
    
    // MARK: - Shared
    
    static let shared = DiskManager()
    
    // MARK: - Init
    
    override init() {
        super.init()
    }
    
    // MARK: - Cache
    
    override func writePopularMovies(_ showArray: [Show]) {
        self.writeAnyMovies(showArray)
    }
    
    override func getPopularMovies() -> [Show] {
        return self.getAnyMovies()
    }
    
    override func writeTopRatedMovies(_ showArray: [Show]) {
        self.writeAnyMovies(showArray)
    }
    
    override func getTopRatedMovies() -> [Show] {
        return self.getAnyMovies()
    }
    
    override func writeUpcomingMovies(_ showArray: [Show]) {
        self.writeAnyMovies(showArray)
    }
    
    override func getUpcomingMovies() -> [Show] {
        return self.getAnyMovies()
    }
    
    // MARK: - Disk native
    
    func writeAnyMovies(_ showArray: [Show]) {
        var movieId = ""
        for show in showArray {
            let key = "\(show.movieId)"
            do {
                try Disk.save(show, to: .documents, as: key)
                movieId = movieId + "\(key),"
            } catch {
                print("Unexpected error: \(error).")
            }
        }
        
        do {
            var showMethod = ShowMethod(dictionary: ["method":Request.shared.method as AnyObject, "movieId": movieId as AnyObject])
            try Disk.save(showMethod, to: .documents, as: Request.shared.method!)
        } catch {
            print("Unexpected error: \(error).")
        }
        
    }
    
    func getAnyMovies() -> [Show] {
        var showArray: [Show] = []
        var key = Request.shared.method
        do {
            let showMethod = try Disk.retrieve(key!, from: .documents, as: ShowMethod.self)
            let collection  = showMethod.movieId!.components(separatedBy: ",")
            var show: Show
            for movieId in collection {
                show = try Disk.retrieve(movieId, from: .documents, as: Show.self)
                showArray.append(show)
            }
        } catch {
            print("Unexpected error: \(error).")
        }
        return showArray
    }
}


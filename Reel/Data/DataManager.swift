//
//  DataManager.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 8/4/19.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation

protocol DataFoundation {

    /**
     Write popular
     */
    func writePopularMovies(_ showArray: [Show])
    
    /**
     Read popular
     */
    func getPopularMovies() -> [Show]
    
    /**
     Write top rated
     */
    func writeTopRatedMovies(_ showArray: [Show])
    
    /**
     Read top rated
     */
    func getTopRatedMovies() -> [Show]

    /**
     Write upcoming
     */
    func writeUpcomingMovies(_ showArray: [Show])
    
    /**
     Read upcomin
     */
    func getUpcomingMovies() -> [Show]

    
}

class DataManager: DataFoundation {
    func writePopularMovies(_ showArray: [Show]) {
    }
    
    func getPopularMovies() -> [Show] {
        return []
    }
    
    func writeTopRatedMovies(_ showArray: [Show]) {
    }
    
    func getTopRatedMovies() -> [Show] {
        return []
    }

    func writeUpcomingMovies(_ showArray: [Show]) {
    }
    
    func getUpcomingMovies() -> [Show] {
        return []
    }
}

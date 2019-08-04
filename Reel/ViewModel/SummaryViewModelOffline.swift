//
//  SummaryViewModelOffline.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 8/3/19.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation

class SummaryViewModelOffline: SummaryViewModel {
    
    // MARK: - Retrieve for view
    
    override func getPopularMovies() {
        super.getPopularMovies()
        self.summaryViewController.popularMoviesArray = DiskManager.shared.getPopularMovies()
        self.refreshSummary()
    }
    
    override func getTopRatedMovies() {
        super.getTopRatedMovies()
        self.summaryViewController.topRatedMoviesArray = DiskManager.shared.getTopRatedMovies()
        self.refreshSummary()
    }
    
    override func getUpcomingMovies() {
        super.getUpcomingMovies()
        self.summaryViewController.upcomingMoviesArray = DiskManager.shared.getUpcomingMovies()
        self.refreshSummary()
    }
    
    override func getSearchTextMovies(_ searchText: String) {
    }
    
    func writePopularMovies(_ showArray: [Show]) {
        DiskManager.shared.writePopularMovies(showArray)
    }

    func writeTopRatedMovies(_ showArray: [Show]) {
        DiskManager.shared.writeTopRatedMovies(showArray)
    }

    func writeUpcomingMovies(_ showArray: [Show]) {
        DiskManager.shared.writeUpcomingMovies(showArray)
    }

}

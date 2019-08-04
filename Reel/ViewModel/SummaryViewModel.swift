//
//  SummaryViewModel.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 8/3/19.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation

class SummaryViewModel {
    
    // MARK: - ViewController
    
    var summaryViewController: SummaryViewController!
    
    // MARK: - Retrieve for view
    
    func getPopularMovies() {
    }
    
    func getTopRatedMovies() {
    }
    
    func getUpcomingMovies() {
    }
    
    func getSearchTextMovies(_ searchText: String) {
    }
    
    // MARK: - Refresh
    
    func refreshSummary() {
        self.summaryViewController.initDictionaryForArrays()
        //self.stopActivityIndicator()
        self.summaryViewController.movieTableView.reloadData()
    }
}

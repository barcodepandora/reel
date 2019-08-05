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
        Request.shared.method = Request.Methods.SearchPopularMovie // Save method
    }
    
    func getTopRatedMovies() {
        Request.shared.method = Request.Methods.SearchTopRatedMovies
    }
    
    func getUpcomingMovies() {
        Request.shared.method = Request.Methods.SearchUpcomingMovies
    }
    
    func getSearchTextMovies(_ searchText: String) {
    }
    
    // MARK: - Refresh
    
    func refreshSummary() {
        self.summaryViewController.initDictionaryForArrays()
        self.summaryViewController.movieTableView.reloadData()
    }
}

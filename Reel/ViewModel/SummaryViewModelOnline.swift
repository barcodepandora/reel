//
//  SummaryViewModelOnline.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 8/3/19.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation

class SummaryViewModelOnline: SummaryViewModel {
    
    // MARK: - Character
    var summaryViewModelOffline = SummaryViewModelOffline()
    
    // MARK: - Retrieve for view
    
    override func getPopularMovies() {
        super.getPopularMovies()
        RequestSummary().getSummary(method: Request.Methods.SearchPopularMovie, limitForPages: 306)  { (success, collectionShow, error) in
            DispatchQueue.main.async {
                if success {
                    if let popularMovies = collectionShow {
                        self.summaryViewController.popularMoviesArray = popularMovies
                        self.summaryViewModelOffline.writePopularMovies(popularMovies)
                        self.refreshSummary()
                    }
                } else {
                    self.summaryViewController.displayAlertView("Error Request Popular", error)
                }
            }
        }
    }
    
    override func getTopRatedMovies() {
        super.getTopRatedMovies()
        RequestSummary().getSummary(method: Request.Methods.SearchTopRatedMovies, limitForPages: 15)  { (success, collectionShow, error) in
            DispatchQueue.main.async {
                if success {
                    if let topRatedMovies = collectionShow {
                        self.summaryViewController.topRatedMoviesArray = topRatedMovies
                        self.summaryViewModelOffline.writeTopRatedMovies(topRatedMovies)
                        self.refreshSummary()
                    }
                } else {
                    self.summaryViewController.displayAlertView("Error Request Top Rated", error)
                }
            }
        }
    }
    
    override func getUpcomingMovies() {
        super.getUpcomingMovies()
        RequestSummary().getSummary(method: Request.Methods.SearchUpcomingMovies, limitForPages: 15)  { (success, collectionShow, error) in
            DispatchQueue.main.async {
                if success {
                    if let upcomingMovies = collectionShow {
                        self.summaryViewController.upcomingMoviesArray = upcomingMovies
                        self.summaryViewModelOffline.writeUpcomingMovies(upcomingMovies)
                        self.refreshSummary()
                    }
                } else {
                    self.summaryViewController.displayAlertView("Error Request Upcoming", error)
                }
            }
        }
    }
    
    override func getSearchTextMovies(_ searchText: String) {
                RequestSearchString().getMoviesForSearchString(searchText) { (success, searchTextMovies, error) in
                    DispatchQueue.main.async {
                        if success {
                            if let searchTextMovies = searchTextMovies {
        //                        debugPrint("\(searchTextMovies)")
                                self.summaryViewController.filteredMoviesArray = searchTextMovies
                                self.refreshSummary()
                            }
                        } else {
                            self.summaryViewController.displayAlertView("Error Request Search", error)
                        }
                    }
                }
    }
}

//
//  SummaryViewModelOnline.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 8/3/19.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation
import Realm

class SummaryViewModelOnline: SummaryViewModel {
    
    // MARK: - Character
    var summaryViewModelOffline = SummaryViewModelOffline()
    
    // MARK: - Retrieve for view
    
    override func getPopularMovies() {
        Request.getSummary(method: Request.Methods.SearchPopularMovie, limitForPages: 306)  { (success, collectionShow, error) in
            DispatchQueue.main.async {
                if success {
                    if let popularMovies = collectionShow {
                        self.summaryViewController.popularMoviesArray = popularMovies
//                        self.summaryViewMod"elOffline.writePopularMoviesArray(popularMovies)
//                        try! realm.write {
//                            realm.add(husband)
//                        }
                        self.refreshSummary()
                    }
                } else {
                    self.summaryViewController.displayAlertView("Error Request Popular", error)
                }
            }
        }
    }
    
    override func getTopRatedMovies() {
        Request.getSummary(method: Request.Methods.SearchTopRatedMovies, limitForPages: 15)  { (success, collectionShow, error) in
            DispatchQueue.main.async {
                if success {
                    if let topRatedMovies = collectionShow {
                        self.summaryViewController.topRatedMoviesArray = topRatedMovies
                        self.refreshSummary()
                    }
                } else {
                    self.summaryViewController.displayAlertView("Error Request Top Rated", error)
                }
            }
        }
    }
    
    override func getUpcomingMovies() {
        Request.getSummary(method: Request.Methods.SearchUpcomingMovies, limitForPages: 15)  { (success, collectionShow, error) in
            DispatchQueue.main.async {
                if success {
                    if let upcomingMovies = collectionShow {
                        self.summaryViewController.upcomingMoviesArray = upcomingMovies
                        self.refreshSummary()
                    }
                } else {
                    self.summaryViewController.displayAlertView("Error Request Upcoming", error)
                }
            }
        }
    }
    
    override func getSearchTextMovies(_ searchText: String) {
        Request.getSummary(method: Request.Methods.SearchUpcomingMovies, limitForPages: 500)  { (success, collectionShow, error) in
            DispatchQueue.main.async {
                if success {
                    if let searchTextMovies = collectionShow {
                        self.summaryViewController.filteredMoviesArray = searchTextMovies
                        self.refreshSummary()
                    }
                } else {
                    self.summaryViewController.displayAlertView("Error Request Filtered", error)
                }
            }
        }
        
        //        Request.getMoviesForSearchString(searchText) { (success, searchTextMovies, error) in
        //            DispatchQueue.main.async {
        //                if success {
        //                    if let searchTextMovies = searchTextMovies {
        ////                        debugPrint("\(searchTextMovies)")
        //                        self.filteredMoviesArray = searchTextMovies
        //                        self.refreshSummary()
        //                    }
        //                } else {
        //                    self.displayAlertView("Error Request Search", error)
        //                }
        //            }
        //        }
    }    
}

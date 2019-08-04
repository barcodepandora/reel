//
//  SummaryViewModel.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 02/09/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import UIKit

/*
 Extension for ViewController
 According to MMVM Pattern
 According to O for SOLID
 */
extension SummaryViewController {
	
	// MARK: - Retrieve for view
	
	func getPopularMovies() {
        Request.getSummary(method: Request.Methods.SearchPopularMovie, limitForPages: 306)  { (success, collectionShow, error) in
            DispatchQueue.main.async {
                if success {
                    if let popularMovies = collectionShow {
                        self.popularMoviesArray = popularMovies
                        self.refreshSummary()
                    }
                } else {
                    self.displayAlertView("Error Request Popular", error)
                }
            }
         }
	}
	
	func getTopRatedMovies() {
        Request.getSummary(method: Request.Methods.SearchTopRatedMovies, limitForPages: 15)  { (success, collectionShow, error) in
            DispatchQueue.main.async {
                if success {
                    if let topRatedMovies = collectionShow {
                        self.topRatedMoviesArray = topRatedMovies
                        self.refreshSummary()
                    }
                } else {
                    self.displayAlertView("Error Request Top Rated", error)
                }
            }
        }
	}
	
	func getUpcomingMovies() {
        Request.getSummary(method: Request.Methods.SearchUpcomingMovies, limitForPages: 15)  { (success, collectionShow, error) in
            DispatchQueue.main.async {
                if success {
                    if let upcomingMovies = collectionShow {
                        self.upcomingMoviesArray = upcomingMovies
                        self.refreshSummary()
                    }
                } else {
                    self.displayAlertView("Error Request Upcoming", error)
                }
            }
        }
	}
	
	func getSearchTextMovies(_ searchText: String) {
        Request.getSummary(method: Request.Methods.SearchUpcomingMovies, limitForPages: 500)  { (success, collectionShow, error) in
            DispatchQueue.main.async {
                if success {
                    if let searchTextMovies = collectionShow {
                        self.filteredMoviesArray = searchTextMovies
                        self.refreshSummary()
                    }
                } else {
                    self.displayAlertView("Error Request Filtered", error)
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
	
    // MARK: - Refresh
    
    func refreshSummary() {
        self.initDictionaryForArrays()
        //self.stopActivityIndicator()
        self.movieTableView.reloadData()
    }
}

//
//  SummarySearchController.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 02/09/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//


import UIKit

extension SummaryViewController: UISearchResultsUpdating {

    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
		let searchBar = searchController.searchBar
		let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
		if searchBar.text == "" {
            // TODO: Show all
		} else {
            filterContentForSearchText(searchController.searchBar.text!, scope: scope)
		}
	}
}

extension SummaryViewController: UISearchBarDelegate {
    
    // MARK: - Search Bar Delegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if let task = searchTask { // task
			task.cancel()
		}
		if searchText == "" {
			filteredMoviesArray = [Show]()
			self.refreshSummary()
			return
		}
		if !searchText.isEmpty {
            getSearchTextMovies(searchText)
		}
	}
	
	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		switch selectedScope {
		case 0:
			self.navigationItem.title = Constant.EXPLORE
		case 1:
			self.navigationItem.title = Constant.POPULAR
			self.summaryViewModel!.getPopularMovies()
		case 2:
			self.navigationItem.title = Constant.TOP_RATED
			self.summaryViewModel!.getTopRatedMovies()
		case 3:
			self.navigationItem.title = Constant.UPCOMING
			self.summaryViewModel!.getUpcomingMovies()
		default:
			print("selectedScopeButtonIndexDidChange Default")
		}
	}
	
    // MARK: - Validate
    
	func searchBarIsEmpty() -> Bool {
		debugPrint("Search written")
		return searchController.searchBar.text?.isEmpty ?? true
	}
	
	func filterContentForSearchText(_ searchText: String, scope: String = "Explore") {
        filteredMoviesArray = filteredMoviesArray!.filter({( movie : Show) -> Bool in
					let doesCategoryMatch = (scope == "Explore") 
		
					if searchBarIsEmpty() {
						return doesCategoryMatch
					} else {
						return doesCategoryMatch && movie.title!.lowercased().contains(searchText.lowercased())
					}
				})
				self.refreshSummary()
	}
	
	func isFiltering() -> Bool {
		let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
		return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
	}
}

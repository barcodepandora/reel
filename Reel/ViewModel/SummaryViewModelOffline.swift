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
    }
    
    override func getTopRatedMovies() {
    }
    
    override func getUpcomingMovies() {
    }
    
    override func getSearchTextMovies(_ searchText: String) {
    }
    
    func writePopularMoviesArray(_ showArray: [Show]) {
        RealmManager.shared.writePopularMoviesArray(showArray)
    }
}

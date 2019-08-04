//
//  SummaryController.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 02/09/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
	
    // MARK: - Character
    
	var movie: Show?
    var popularMoviesArray: [Show]?
    var topRatedMoviesArray: [Show]?
    var upcomingMoviesArray: [Show]?
    var filteredMoviesArray: [Show]?
    var dictionaryForShowArrays: [String: [Show]]?
    var summaryViewModel: SummaryViewModel?
    var isOnline = false
	
	// MARK: - Show
    
	var detailViewController: ShowViewController?
	
	// MARK: - Search
    
	let searchController = UISearchController(searchResultsController: nil)
	var searchTask: URLSessionDataTask?
	
	// MARK: - Outlet
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var movieTableView: UITableView!

	// MARK: - View
	
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareViewModel()
        self.navigationItem.title = Constant.EXPLORE
        self.prepareSearchAndScopeBar()
        self.preparaShowViewController()
        self.initCharacter()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		if splitViewController!.isCollapsed {
			if let selectionIndexPath = self.movieTableView.indexPathForSelectedRow {
				self.movieTableView.deselectRow(at: selectionIndexPath, animated: animated)
			}
		}
		super.viewWillAppear(animated)
	}
	
	// MARK: - Action

    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
		switch navigationItem.title {
		case Constant.POPULAR:
            self.summaryViewModel!.getPopularMovies()
		case Constant.TOP_RATED:
			self.summaryViewModel!.getTopRatedMovies()
		case Constant.UPCOMING:
			self.summaryViewModel!.getUpcomingMovies()
		default:
			print("Default")
		}
	}

	// MARK: - Prepare
	
    func prepareViewModel() {
        if self.isOnline {
            self.summaryViewModel = SummaryViewModelOnline()
        } else {
            self.summaryViewModel = SummaryViewModelOffline()
        }
        self.summaryViewModel?.summaryViewController = self
    }
    
	func preparaShowViewController(){
		if let splitViewController = splitViewController {
			let controllers = splitViewController.viewControllers
			detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ShowViewController
		}
	}
	
	func prepareSearchAndScopeBar() {
		self.searchController.searchResultsUpdater = self // protocol UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
		self.navigationItem.searchController = searchController
		self.definesPresentationContext = true
		self.searchController.searchBar.delegate = self
		let categories = [Constant.EXPLORE.components(separatedBy: " ")[0], Constant.POPULAR.components(separatedBy: " ")[0], Constant.TOP_RATED.components(separatedBy: " ")[0], Constant.UPCOMING.components(separatedBy: " ")[0]]
		self.searchController.searchBar.scopeButtonTitles = categories
	}
	
    func initCharacter() {
        self.popularMoviesArray     = [Show]()
        self.topRatedMoviesArray    = [Show]()
        self.upcomingMoviesArray    = [Show]()
        self.filteredMoviesArray    = [Show]()
        self.initDictionaryForArrays()
    }
    
    func initDictionaryForArrays() {
        self.dictionaryForShowArrays = [Constant.EXPLORE: self.filteredMoviesArray, Constant.POPULAR: self.popularMoviesArray, Constant.TOP_RATED: self.topRatedMoviesArray, Constant.UPCOMING: self.upcomingMoviesArray] as! [String : [Show]]
    }
    
	// MARK: Status Bar
    
//    override var prefersStatusBarHidden: Bool { return true }
	

    // MARK: - Alert
    
	func displayAlertView(_ title: String?, _ error: String?) {
		if error != nil {
			let alertController = UIAlertController(title: title, message: error, preferredStyle: .alert)
			let OKAction = UIAlertAction(title: "OK", style: .default) { action in
			}
			alertController.addAction(OKAction)
			self.present(alertController, animated: true) {}
		}
	}
}








//
//  SummaryController.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 02/09/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import UIKit
import RxSwift

class SummaryViewController: UIViewController, ATCWalkthroughViewControllerDelegate {
	
    // MARK: - Character
    
	var movie: Show?
    var popularMoviesArray: [Show]?
    var topRatedMoviesArray: [Show]?
    var upcomingMoviesArray: [Show]?
    var filteredMoviesArray: [Show]?
    var dictionaryForShowArrays: [String: [Show]]?
    var summaryViewModel: SummaryViewModel?
    weak var welcome: WelcomeViewController?
	
	// MARK: - Show
    
	var detailViewController: ShowViewController?
	
	// MARK: - Search
    
	let searchController = UISearchController(searchResultsController: nil)
	var searchTask: URLSessionDataTask?
	
	// MARK: - Outlet
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var movieTableView: UITableView!

    // MARK: - Reactive
    
    private let baseline = Variable("baseline")
    var gestured:Observable<String> {
        return baseline.asObservable()
    }

	// MARK: - View
	
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doReactive()
        self.prepareViewModel()
        self.navigationItem.title = Constant.EXPLORE
        self.prepareSearchAndScopeBar()
        self.preparaShowViewController()
        self.initCharacter()
        
        self.movieTableView.dataSource = self
        self.movieTableView.delegate = self

    }
	
	override func viewWillAppear(_ animated: Bool) {
		if splitViewController!.isCollapsed {
			if let selectionIndexPath = self.movieTableView.indexPathForSelectedRow {
				self.movieTableView.deselectRow(at: selectionIndexPath, animated: animated)
			}
		}
		super.viewWillAppear(animated)
        
	}
	
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.doForFirstLaunch()

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
        if OnlineManager.shared.isOnline() {
            self.summaryViewModel = SummaryViewModelOnline()
        } else {
            self.summaryViewModel = SummaryViewModelOffline()
        }
        self.summaryViewModel?.summaryViewController = self
    }
    
    func doReactive() {
        RxManager.shared.doObserver(time: 120, summaryViewController: self)
        func refreshFromDelegate() {
            baseline.value = "baselineOnline"
        }
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
    
    func displayAndExit(_ title: String?, _ error: String?) {
        if error != nil {
            let alertController = UIAlertController(title: title, message: error, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                exit(0)
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true) {}
        }
    }
    
    // MARK: - Onboarding
    
    func prepareOnboarding() {
        let walkthroughVC = self.walkthroughVC()
        walkthroughVC.delegate = self
        self.addChildViewControllerWithView(walkthroughVC)

    }

    func walkthroughViewControllerDidFinishFlow(_ vc: ATCWalkthroughViewController) {
        UIView.transition(with: self.view, duration: 1, options: .transitionFlipFromLeft, animations: {
            vc.view.removeFromSuperview()
//            let viewControllerToBePresented = UIViewController()
//            self.view.addSubview(viewControllerToBePresented.view)
        }, completion: nil)
    }
    
    func getOnboardingModel() -> [ATCWalkthroughModel] {
        return [
            ATCWalkthroughModel(title: "No es Link", subtitle: "No ha sido exitoso consultar los recursos de Sketch e importado los servicios de Parse Server. Sin embargo se realizó la prueba de acuerdo a los lineamientos propuestos con otros recursos y servicios", icon: "onboarding001"),
            ATCWalkthroughModel(title: "Si es Charizard", subtitle: "Se propone realizar la prueba con el API de The Movie Database. Seguimos igualmente el brief, el workflow y los requerimientos dados en los enunciados", icon: "onboarding002"),
            ATCWalkthroughModel(title: "ToDo", subtitle: "*Resolver acceso a Parse Server y Sharepoint *Offline-First para opción Explore *UnitTest UITest", icon: "onboarding003"),
        ]
    }
    
    fileprivate func walkthroughVC() -> ATCWalkthroughViewController {
        let viewControllers = self.getOnboardingModel().map { ATCClassicWalkthroughViewController(model: $0, nibName: "ATCClassicWalkthroughViewController", bundle: nil) }
        return ATCWalkthroughViewController(nibName: "ATCWalkthroughViewController",
                                            bundle: nil,
                                            viewControllers: viewControllers)
    }
    
    // MARK: - First time
    
    func doForFirstLaunch() {
        if (FirstLaunch().isFirstLaunch) {
            self.doWelcome()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.welcome!.dismiss(animated: true, completion: nil)
                self.welcome = nil
                self.prepareOnboarding()
            }
        }
    }
    
    func doWelcome() {
        if let welcomeT = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Welcome") as? WelcomeViewController {
            self.welcome = welcomeT
            self.definesPresentationContext = true
            welcome!.modalPresentationStyle = .overFullScreen

            let transition = CATransition() // Transition
            transition.duration = 2
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromTop
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(welcome!, animated: true, completion: nil)
        }

    }

}








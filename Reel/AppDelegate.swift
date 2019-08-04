//
//  AppDelegate.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 02/09/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
			// configura al split view controller como vc raíz
			let splitViewController = window!.rootViewController as! UISplitViewController

		
			let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-2] as! UINavigationController
			navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
			splitViewController.preferredDisplayMode = .allVisible
		splitViewController.delegate = self
		
//            // configura la apariencia de la barra de búsqueda y de la barra de navegación
//            UISearchBar.appearance().tintColor = .movieGreen
//            UINavigationBar.appearance().tintColor = .movieGreen
	
			return true
		}
	
	
		// MARK: - Split view
		func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {

			guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
			guard let topAsDetailController = secondaryAsNavController.topViewController as? ShowViewController else { return false }
			if topAsDetailController.selectedMovie == nil {
				return true
			}
			
			return false
		}

	
}


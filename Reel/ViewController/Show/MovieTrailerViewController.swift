//
//  MovieTrailerViewController.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 02/09/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift

class MovieTrailerViewController: UIViewController {
	
	// MARK: - Character
	
	var selectedMovie: Show?
	var movieTrailersArray: [Show]?
	var firstTrailerArray: [Show] = []
	
	override var prefersStatusBarHidden: Bool { return true }
	
	// MARK: - Outlet

    @IBOutlet weak var movieTrailerVideo: YouTubePlayerView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	// MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
			startActivityIndicator()
			showTrailer()
    }
	
	// MARK: - Business
	
	func showTrailer() {
		for trailer in movieTrailersArray! { firstTrailerArray.append(trailer)}
		let firstTrailer = firstTrailerArray.first
		let oficialVideoKey = firstTrailer?.videoKey; stopActivityIndicator()
        self.movieTrailerVideo.loadVideoID(oficialVideoKey!)
	}
	
	// MARK: - Activity
	
	func startActivityIndicator() {
		activityIndicator.alpha = 1.0
		activityIndicator.startAnimating()
	}
	
	func stopActivityIndicator() {
		activityIndicator.alpha = 0.0
		self.activityIndicator.stopAnimating()
	}
	
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

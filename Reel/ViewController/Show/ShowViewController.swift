//
//  ShowViewController.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 02/09/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
	
	// MARK: - Character
	
	var selectedMovie: Show?
//    var movieTrailers = [Show]()
//    override var prefersStatusBarHidden: Bool { return true }
	
	// MARK: - Outlet
	
	@IBOutlet weak var poster: UIImageView!
	@IBOutlet weak var about: UITextView!
	@IBOutlet weak var qualifyAverage: UILabel!
	@IBOutlet weak var trailerButton: UIButton!
	
	// MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getTitleAndYear(); self.displayDetail(); self.getPosterImage()
    }
	
    // MARK: - Display
    
	func getPosterImage() {
		if let posterPath = selectedMovie?.posterPath {
			let _ = Request.getPosterImage(Request.ParameterValues.posterSizes[2], filePath: posterPath , { (imageData, error) in
				if UIImage(data: imageData!) != nil {
					DispatchQueue.main.async {
						self.poster.contentMode = UIView.ContentMode.scaleAspectFit
						self.poster.image = UIImage(data: imageData!)
					}
				} else {
					print(error ?? "Error displaying poster")
				}
			})
		}
	}
	
    func getTitleAndYear() {
        var title = selectedMovie?.title
        var releaseYear = selectedMovie?.releaseYear
        if let titleString = title, let yearString = releaseYear {
            title = titleString
            releaseYear = yearString
            let titleReleaseYear = titleString + " (\(yearString))"
            self.title = titleReleaseYear
        }
    }
    
    func displayDetail() {
        about.text = selectedMovie?.overview
        let qualifyAverageLocal = "Qualify: \(Float((selectedMovie?.voteAverage)!))"
        qualifyAverage.text = String(qualifyAverageLocal)
        
    }

	// MARK: - Action
	
	@IBAction func trailerButtonPressed(_ sender: UIButton) {
		
//        var movieId: String = String()
//
//        if let selectedMovieId = selectedMovie?.movieId { movieId = String(selectedMovieId) }
//
//        let videoMethod = TMDbClient.Methods.SearchMovie + movieId + TMDbClient.Methods.SearchVideo
//
//        // networking
//        TMDbClient.getMovieTrailer (videoMethod){ (success, movieTrailers, error) in
//
//            DispatchQueue.main.async {
//
//                if success {
//                    // comprueba si la película tiene un trailer disponible
//                    if movieTrailers?.count == 0 {
//                        self.displayAlertView("Trailer No Disponible", "Esta película aún no tiene trailer ")
//                    } else {
//                        // si tiene trailers disponbiles
//                        for item in movieTrailers! {
//                            // los agrega en el array 'firstTrailer'...
//                            self.movieTrailers.append(item)
//                        }
//                        // ... y los envía a la siguiente pantalla
//                        self.performSegue(withIdentifier: "toTrailer", sender: nil)
//                    }
//                } else {
//                    debugPrint(error ?? "")
//                }
//            }
//        } // end trailing closure
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

// MARK: - Segue

extension ShowViewController {
	
	override func prepare(for segue: UIStoryboardSegue,sender: Any?) {
		if segue.identifier == "toTrailer" {
			let trailerVC = segue.destination as! MovieTrailerViewController
			trailerVC.selectedMovie = selectedMovie
//            trailerVC.movieTrailersArray = movieTrailers
		}
	}
}

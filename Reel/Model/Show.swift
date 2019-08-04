//
//  Show.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 02/09/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation

struct Show {
	
	// MARK: - Character
	
	let title: String?
	let movieId: Int?
	let trailerId: Int?
	let posterPath: String?
	let releaseYear: String?
	let overview: String?
	let voteAverage: Double?
	let popularity: Double?
	let videoKey: String?
	
	// MARK: - Initialize
	
	init(dictionary: [String:AnyObject]) {
		title = dictionary[Request.JSONResponseKeys.MovieTitle] as? String
		movieId = dictionary[Request.JSONResponseKeys.MovieID] as? Int
		trailerId = dictionary[Request.JSONResponseKeys.TrailerID] as? Int
		posterPath = dictionary[Request.JSONResponseKeys.MoviePosterPath] as? String
		overview = dictionary[Request.JSONResponseKeys.MovieOverview] as? String
		voteAverage = dictionary[Request.JSONResponseKeys.MovieAverage] as? Double
		popularity = dictionary[Request.JSONResponseKeys.MoviePopularity] as? Double
		videoKey = dictionary[Request.JSONResponseKeys.MovieVideoKey] as? String
		
		if let releaseDateString = dictionary[Request.JSONResponseKeys.MovieReleaseDate] as? String, releaseDateString.isEmpty == false {
			releaseYear = releaseDateString.substring(to: releaseDateString.characters.index(releaseDateString.startIndex, offsetBy: 4))
		} else {
			releaseYear = ""
		}
	}
	
	static func showsFromResults(_ results: [[String:AnyObject]]) -> [Show] {
		var movies = [Show]()
		for result in results {
			movies.append(Show(dictionary: result))
		}
		return movies
	}
}


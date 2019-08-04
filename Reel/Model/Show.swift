//
//  Show.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 02/09/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation

struct Show: Codable {
	
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
//    let method: String?
	
	// MARK: - Init
	
	init(dictionary: [String:AnyObject]) {
		self.title = dictionary[Request.JSONResponseKeys.MovieTitle] as? String
		self.movieId = dictionary[Request.JSONResponseKeys.MovieID] as? Int
		self.trailerId = dictionary[Request.JSONResponseKeys.TrailerID] as? Int
		self.posterPath = dictionary[Request.JSONResponseKeys.MoviePosterPath] as? String
		self.overview = dictionary[Request.JSONResponseKeys.MovieOverview] as? String
		self.voteAverage = dictionary[Request.JSONResponseKeys.MovieAverage] as? Double
		self.popularity = dictionary[Request.JSONResponseKeys.MoviePopularity] as? Double
		self.videoKey = dictionary[Request.JSONResponseKeys.MovieVideoKey] as? String
		
		if let releaseDateString = dictionary[Request.JSONResponseKeys.MovieReleaseDate] as? String, releaseDateString.isEmpty == false {
			releaseYear = releaseDateString.substring(to: releaseDateString.characters.index(releaseDateString.startIndex, offsetBy: 4))
		} else {
			releaseYear = ""
		}
        
//        self.method = Request.shared.method // init with method
        
	}
	
	static func showsFromResults(_ results: [[String:AnyObject]]) -> [Show] {
		var movies = [Show]()
		for result in results {
			movies.append(Show(dictionary: result))
		}
		return movies
	}
}

struct ShowMethod: Codable {
    
    // MARK: - Character
    
    let method: String?
    let movieId: String?

    // MARK: - Init
    
    init(dictionary: [String:AnyObject]) {
        self.method = dictionary["method"] as? String
        self.movieId = dictionary["movieId"] as? String
    }
}


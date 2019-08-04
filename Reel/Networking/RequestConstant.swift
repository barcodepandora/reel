//
//  RequestConstant.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 02/09/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation

extension Request {
	
	// MARK: - URL
	
	struct Constants {
		static let ApiKey = "0942529e191d0558f888245403b4dca7" // apikey
        static let UserID = "id"
		static let ApiScheme = "https"
		static let ApiHost = "api.themoviedb.org"
		static let ApiPath = "/3"
		static let YouTubeBaseURL = "https://www.youtube.com/watch?v="
	}
	
	// MARK: - Method
    
	struct Methods {
		static let SearchPopularMovie = "/movie/popular"
		static let SearchTopRatedMovies = "/movie/top_rated"
		static let SearchUpcomingMovies = "/movie/upcoming"
		static let SearchMovie = "/movie/"
		static let SearchVideo = "/videos"
		static let SearchTextMovie = "/search/movie"
	}
	
	// MARK: - Parameter
	
	struct ParameterKeys {
		static let ApiKey = "api_key"
		static let Language = "language"
		static let Page = "page"
		static let Query = "query"
	}
	
	struct ParameterValues {
		static let ApiKey = "0942529e191d0558f888245403b4dca7"
		static let Language = "en-US"
		static let secureBaseImageURLString = "https://image.tmdb.org/t/p/"
		static let posterSizes = ["w92", "w154", "w185", "w342", "w500", "w780", "original"]
	}

	// MARK: - Response
	
	struct JSONResponseKeys {
		
		// Main
		static let StatusMessage = "status_message" // Main
		static let StatusCode = "status_code"

		// Config
		static let ConfigBaseImageURL = "base_url"
		static let ConfigSecureBaseImageURL = "secure_base_url"
		static let ConfigImages = "images"
		static let ConfigPosterSizes = "poster_sizes"
		static let ConfigProfileSizes = "profile_sizes"
		
		// Show
		static let Results = "results"
		static let TotalPages = "total_pages"

		// Character
		static let MovieID = "id"
		static let TrailerID = "id"
		static let MovieTitle = "title"
		static let MoviePosterPath = "poster_path"
		static let MovieReleaseDate = "release_date"
		static let MovieReleaseYear = "release_year"
		static let MovieOverview = "overview"
		static let MovieResults = "results"
		static let MovieAverage = "vote_average"
		static let MoviePopularity = "popularity"
		
		// Video
		static let MovieVideoKey = "key"
		}
	}

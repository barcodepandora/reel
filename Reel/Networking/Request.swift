//
//  Request.swift
//  Reel
//
//  Created by Juan Manuel Moreno Beltrán on 02/09/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation
import Alamofire

class Request: NSObject {
	
	// MARK: - Init
	
	override init() {
		super.init()
	}
	
	// MARK: - Character
	var session = URLSession.shared
	
	// MARK: - Networking
	
    static func getSummary(method: String, limitForPages: Int, completionHandlerForRequest: @escaping ( _ success: Bool, _ collectionShow: [Show]?, _ errorString: String?) -> Void) {
        
        let totalPagesRandom = Int.random(in: 1 ..< limitForPages)
        let chosen = String(totalPagesRandom)
        
        Alamofire.request(configureUrl(method, page: chosen)).responseJSON { response in
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("Request OK")
                default:
                    let errorMessage = "Request KO: \(status)"
                    completionHandlerForRequest(false, nil, errorMessage)
                }
            }
            
            if let jsonObjectResult: Any = response.result.value {
                let jsonObjectResultDictionary = jsonObjectResult as! [String:AnyObject]
                debugPrint("Result: \(jsonObjectResult)") // JSON obtenido
                if let results = jsonObjectResultDictionary[Request.JSONResponseKeys.Results], let totalPages = jsonObjectResultDictionary[Request.JSONResponseKeys.TotalPages] {
                    let resultsFavoriteMovies = Show.showsFromResults(results as! [[String : AnyObject]])
                    debugPrint("Number: \(totalPages)")
                    completionHandlerForRequest(true, resultsFavoriteMovies, nil)
                }
            }
        }
    }
	
	// MARK: Image

    static func getPosterImage(_ size: String, filePath: String, _ completionHandlerForPosterImage: @escaping ( _ imageData: Data?, _ error: String?) -> Void) {
		
		let baseURL = URL(string: Request.ParameterValues.secureBaseImageURLString)!
		let url = baseURL.appendingPathComponent(size).appendingPathComponent(filePath)
		let request = URLRequest(url: url)
		
		Alamofire.request(request).responseData { response in
			
			// response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("Request OK")
				default:
					let errorMessage = "Request KO: \(status)"
					completionHandlerForPosterImage(nil, errorMessage)
				}
			}
			
			if let dataObjectResult: Any = response.result.value {
				let dataObjectResult = dataObjectResult as! Data
				completionHandlerForPosterImage(dataObjectResult, nil)
				debugPrint("Result: \(dataObjectResult)")
			}
		}
	}
	
//    static func getMoviesForSearchString(_ searchString: String, completionHandlerForMovies: @escaping (_ success: Bool, _ result: [Show]?, _ error: String?) -> Void)  {
//
//        //https://api.themoviedb.org/3/search/movie?api_key=0942529e191d0558f888245403b4dca7&query=Is
//        /* 1. 📞 Realiza la llamada a la API, a través de la función request() de Alamofire 🚀 */
//        Alamofire.request(configureUrlSearchText(Request.Methods.SearchTextMovie, searchString: searchString)).responseJSON { response in
//
//
//            // response status code
//            if let status = response.response?.statusCode {
//                switch(status){
//                case 200:
//                    print("example success")
//                default:
//                    let errorMessage = "error with response status: \(status)"
//                    completionHandlerForMovies(false, nil, errorMessage)
//                }
//            }
//
//            /* 2. Almacena la respuesta del servidor (response.result.value) en la constante 'jsonObjectResult' 📦 */
//            if let jsonObjectResult: Any = response.result.value {
//
//                let jsonObjectResultDictionary = jsonObjectResult as! [String:AnyObject]
//
//                debugPrint("🤜JSON TEXT SEARCH MOVIES: \(jsonObjectResult)") // JSON obtenido
//
//                if let results = jsonObjectResultDictionary[Request.JSONResponseKeys.Results] {
//
//                    let resultsMovieTextSearch = Show.showsFromResults(results as! [[String : AnyObject]])
//
//                    //test
//                    debugPrint("🤾🏼‍♂️ TMDBMovie...\(resultsMovieTextSearch)")
//
//                    completionHandlerForMovies(true, resultsMovieTextSearch, nil)
//
//                }
//            }
//
//        }
//
//    }
	
	
	// MARK: Trailer

    static func getMovieTrailer(_ videoMethod: String, _ completionHandlerForVideo: @escaping (_ success: Bool, _ videoTrailer: [Show]?, _ error: String?) -> Void) {
        
        Alamofire.request(configureUrl(videoMethod)).responseJSON { response in
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("Response OK")
                default:
                    let errorMessage = "Response KO: \(status)"
                    completionHandlerForVideo(false, nil, errorMessage)
                }
            }
            
            if let jsonObjectResult: Any = response.result.value {
                debugPrint("JSON\(jsonObjectResult)")
                let jsonObjectResultDictionary = jsonObjectResult as! [String:AnyObject]
                
                debugPrint("Result \(jsonObjectResultDictionary)")
                
                if let results = jsonObjectResultDictionary[Request.JSONResponseKeys.Results], let movieId = jsonObjectResultDictionary[Request.JSONResponseKeys.MovieID] {
                    debugPrint("Foundation \(movieId)")
                    let resultsVideoMovie = Show.showsFromResults(results as! [[String : AnyObject]])
                    debugPrint("Trailer: \(resultsVideoMovie.count)")
                    completionHandlerForVideo(true, resultsVideoMovie, nil)
                } else {
                    completionHandlerForVideo(false, nil, "error")
                }
            }
        }
    }
	
	
	// MARK: - Util
	
	static func configureUrl(_ methodRequest: String, page: String? = nil, searchString: String? = nil) -> URL {
		var components = URLComponents()
		components.scheme = Request.Constants.ApiScheme
		components.host = Request.Constants.ApiHost
		components.path = Request.Constants.ApiPath + methodRequest
		components.queryItems = [URLQueryItem]()
		let queryItem1 = URLQueryItem(name: Request.ParameterKeys.ApiKey, value: Request.ParameterValues.ApiKey)
		let queryItem2 = URLQueryItem(name: Request.ParameterKeys.Language, value: Request.ParameterValues.Language)
		let queryItem3 = URLQueryItem(name: Request.ParameterKeys.Page, value: page)
		components.queryItems?.append(queryItem1) // api key
		components.queryItems?.append(queryItem2) // language
		components.queryItems?.append(queryItem3) // page
		
		return components.url!
	}
	
	static func configureUrlSearchText(_ methodRequest: String, searchString: String?) -> URL {
		var components = URLComponents()
		components.scheme = Request.Constants.ApiScheme
		components.host = Request.Constants.ApiHost
		components.path = Request.Constants.ApiPath + methodRequest
		components.queryItems = [URLQueryItem]()
		let queryItem1 = URLQueryItem(name: Request.ParameterKeys.ApiKey, value: Request.ParameterValues.ApiKey)
		let queryItem2 = URLQueryItem(name: Request.ParameterKeys.Query, value: searchString)
		components.queryItems?.append(queryItem1) // api key
		components.queryItems?.append(queryItem2) // query
		
		return components.url!
	}
}

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

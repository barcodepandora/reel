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
	
    // MARK: - Shared
    
    static let shared = Request()
    
    // MARK: - Character
    
    var method: String?
    
	// MARK: - Init
	
	override init() {
		super.init()
	}
	
	// MARK: - Character
	var session = URLSession.shared
			
	// MARK: Trailer

//    static func getMovieTrailer(_ videoMethod: String, _ completionHandlerForVideo: @escaping (_ success: Bool, _ videoTrailer: [Show]?, _ error: String?) -> Void) {
//        
//        Alamofire.request(configureUrl(videoMethod)).responseJSON { response in
//            if let status = response.response?.statusCode {
//                switch(status){
//                case 200:
//                    print("Response OK")
//                default:
//                    let errorMessage = "Response KO: \(status)"
//                    completionHandlerForVideo(false, nil, errorMessage)
//                }
//            }
//            
//            if let jsonObjectResult: Any = response.result.value {
//                debugPrint("JSON\(jsonObjectResult)")
//                let jsonObjectResultDictionary = jsonObjectResult as! [String:AnyObject]
//                
//                debugPrint("Result \(jsonObjectResultDictionary)")
//                
//                if let results = jsonObjectResultDictionary[Request.JSONResponseKeys.Results], let movieId = jsonObjectResultDictionary[Request.JSONResponseKeys.MovieID] {
//                    debugPrint("Foundation \(movieId)")
//                    let resultsVideoMovie = Show.showsFromResults(results as! [[String : AnyObject]])
//                    debugPrint("Trailer: \(resultsVideoMovie.count)")
//                    completionHandlerForVideo(true, resultsVideoMovie, nil)
//                } else {
//                    completionHandlerForVideo(false, nil, "error")
//                }
//            }
//        }
//    }
	
	
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

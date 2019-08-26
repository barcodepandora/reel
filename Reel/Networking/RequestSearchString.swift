//
//  RequestSearchString.swift
//  Reel
//
//  Created by Juan Manuel Moreno on 26/08/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation
import Alamofire

class RequestSearchString: Request {
    func getMoviesForSearchString(_ searchString: String, completionHandlerForMovies: @escaping (_ success: Bool, _ result: [Show]?, _ error: String?) -> Void)  {
        
        Alamofire.request(Request.configureUrlSearchText(Request.Methods.SearchTextMovie, searchString: searchString)).responseJSON { response in
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("example success")
                default:
                    let errorMessage = "error with response status: \(status)"
                    completionHandlerForMovies(false, nil, errorMessage)
                }
            }
            if let jsonObjectResult: Any = response.result.value {
                let jsonObjectResultDictionary = jsonObjectResult as! [String:AnyObject]
                debugPrint("Result: \(jsonObjectResult)") // JSON obtenido
                if let results = jsonObjectResultDictionary[Request.JSONResponseKeys.Results] {
                    let resultsMovieTextSearch = Show.showsFromResults(results as! [[String : AnyObject]])
                    debugPrint("Result...\(resultsMovieTextSearch)")
                    completionHandlerForMovies(true, resultsMovieTextSearch, nil)
                    
                }
            }
        }
    }

}

//
//  RequestMovieTrailer.swift
//  Reel
//
//  Created by Juan Manuel Moreno on 26/08/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation
import Alamofire

class RequestMovieTrailer: Request {
    func getMovieTrailer(_ videoMethod: String, _ completionHandlerForVideo: @escaping (_ success: Bool, _ videoTrailer: [Show]?, _ error: String?) -> Void) {
        
        Alamofire.request(Request.configureUrl(videoMethod)).responseJSON { response in
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

}

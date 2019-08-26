//
//  RequestSummary.swift
//  Reel
//
//  Created by Juan Manuel Moreno on 26/08/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation
import Alamofire

class RequestSummary: Request {
    func getSummary(method: String, limitForPages: Int, completionHandlerForRequest: @escaping ( _ success: Bool, _ collectionShow: [Show]?, _ errorString: String?) -> Void) {
        
        let totalPagesRandom = Int.random(in: 1 ..< limitForPages)
        let chosen = String(totalPagesRandom)
        
        Alamofire.request(Request.configureUrl(method, page: chosen)).responseJSON { response in
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
}

//
//  RequestPoster.swift
//  Reel
//
//  Created by Juan Manuel Moreno on 26/08/2019.
//  Copyright © 2019 Uzupis. All rights reserved.
//

import Foundation
import Alamofire

class RequestPoster: Request {
    func getPosterImage(_ size: String, filePath: String, _ completionHandlerForPosterImage: @escaping ( _ imageData: Data?, _ error: String?) -> Void) {
        
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
}

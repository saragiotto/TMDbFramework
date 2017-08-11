//
//  TMDbRetrierHandler.swift
//  Pods
//
//  Created by Leonardo Augusto N Saragiotto on 10/08/17.
//
//

import Foundation
import Alamofire

class TMDbRetrierHandler: RequestRetrier {
    
    public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion:@escaping RequestRetryCompletion) {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 429 {
            completion(true, 10.0) // retry after 10 seconds
        } else {
            completion(false, 0.0) // don't retry
        }
    }
}

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
    
    var lastResquests:[Date]
    
    let requestLimit: Int!
    let windowInterval: Double!
    
    static let sharedInstance: TMDbRetrierHandler = {
        let instance = TMDbRetrierHandler()
        
        return instance
    }()
    
    private init() {
        lastResquests = Array.init()
        requestLimit = 40
        windowInterval = 10.0
    }
    
    func addRequest() {
        if (lastResquests.count >= requestLimit) {
            lastResquests.remove(at: lastResquests.startIndex)
        }
        lastResquests.append(Date())
    }
    
    func timeDistance() -> Double {
        
        if (lastResquests.count == 0) {
            return windowInterval
        }
        
        let diff = lastResquests.last!.timeIntervalSince(lastResquests.first!)
        print("Retry in \(diff) seconds")
        return (diff <= windowInterval) ? diff : windowInterval
    }
    
    public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion:@escaping RequestRetryCompletion) {
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 429 {
            completion(true, timeDistance()) // retry after 10 seconds
        } else {
            completion(false, 0.0) // don't retry
        }
    }
}

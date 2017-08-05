//
//  TMDb.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 8/4/17.
//
//

import Foundation
import Alamofire

final class TMDb {
    
    public var bearerAuth: String = ""
    
    public let alamofireManager:SessionManager
    
    static let sharedInstance: TMDb = {
        let instance = TMDb()
        
        return instance
    }()
    
    private init() {
        let urlConfig = URLSessionConfiguration.default
        urlConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        self.alamofireManager = Alamofire.SessionManager(configuration: urlConfig)
    }
    
    public func buildURLWith(endpoint:String) -> String {
        
        let finalString = TMDbEnunsConsts.baseTMDbURLV3 + endpoint + "api_key=" + TMDbEnunsConsts.apiKeyV3 + "&language=en-US"
        
        return finalString
    }
    
}

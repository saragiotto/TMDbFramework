//
//  TMDb.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 8/4/17.
//
//

import Foundation
import Alamofire

open class TMDb {
    
    public var imageQuality: TMDbImageQuality
    public var apiKey: String
    public var language: TMDbLanguage
    public var configurations: TMDbConfiguration?
    
    internal let alamofireManager:SessionManager
    internal var genres: [TMDbGenre]?
    
    public static let shared: TMDb = {
        let instance = TMDb()
        
        return instance
    }()
    
    private init() {
        let urlConfig = URLSessionConfiguration.default
        urlConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        self.alamofireManager = Alamofire.SessionManager(configuration: urlConfig)
        self.alamofireManager.retrier = TMDbRetrierHandler.shared
        self.imageQuality = .medium
        self.apiKey = ""
        self.language = .english
    }
}


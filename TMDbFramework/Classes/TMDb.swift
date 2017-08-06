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
    
    public var bearerAuth: String = ""
    
    public let alamofireManager:SessionManager
    
    private var genreManager:TMDbGenreManager?
    
    public static let sharedInstance: TMDb = {
        let instance = TMDb()
        
        return instance
    }()
    
    private init() {
        let urlConfig = URLSessionConfiguration.default
        urlConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        self.alamofireManager = Alamofire.SessionManager(configuration: urlConfig)
    }
    
    internal func buildURLWith(endpoint:String) -> String {
        
        let finalString = TMDbEnunsConsts.baseTMDbURLV3 + endpoint + "api_key=" + TMDbEnunsConsts.apiKeyV3 + "&language=en-US"
        
        return finalString
    }
    
    public func loadMovies(listType:ListMovieType, page:Int? = nil) {
        
        switch listType {
        case .UpComming:
            TMDbMovieManager.upCommingMovies(page: page)
        case .TopRated:
            TMDbMovieManager.topRatedMovies(page: page)
        default:
            return
        }
    }
    
    public func movieGenreFor(id:Int, completition:@escaping GenreBlock) {
        
        if (self.genreManager == nil) {
            self.genreManager = TMDbGenreManager()
        }
        
        self.genreManager?.movieGenreBy(id, completition)
    }
}

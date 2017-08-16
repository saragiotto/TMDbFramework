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
    
    public let alamofireManager:SessionManager
    
    public var imageQuality: TMDbImageQuality
    public var apiKey: String
    public var configurations: TMDbConfiguration?
    
    private var genreManager:TMDbGenreManager?
    
    public static let sharedInstance: TMDb = {
        let instance = TMDb()
        
        return instance
    }()
    
    private init() {
        let urlConfig = URLSessionConfiguration.default
        urlConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        self.alamofireManager = Alamofire.SessionManager(configuration: urlConfig)
        self.alamofireManager.retrier = TMDbRetrierHandler.sharedInstance
        self.imageQuality = .Medium
        self.apiKey = ""
    }
    
    public func listMoviesOf(type:TMDbListMovieType, page:Int? = nil, _ completition: @escaping MovieListBlock) {
        
        TMDbMovieManager.loadMovieWith(type: type, pageRequest: page, completition)
    }
    
    public func movieGenreFor(id:Int, completition:@escaping GenreBlock) {
        
        if (self.genreManager == nil) {
            self.genreManager = TMDbGenreManager()
        }
        
        self.genreManager!.movieGenreBy(id, completition)
    }
    
    public func loadConfiguration(_ completition:@escaping ConfigurationBlock) {
        if (self.configurations == nil) {
            TMDbConfigurationManager.loadConfiguration({ configs in
                self.configurations = configs
                completition(configs)
            })
        } else {
            completition(self.configurations)
        }
    }
    
    public func loadImageFor(path:String, type:TMDbImageType, _ completition:@escaping ImageBlock) {
        
        TMDbImageManager.imageFor(type: type, path: path, completition)
    }
    
    public func movieDetailFor(movie:TMDbMovie, _ completition: @escaping MovieDetailBlock) {
        
        TMDbMovieManager.detailMovie(movie, completition)
    }
}


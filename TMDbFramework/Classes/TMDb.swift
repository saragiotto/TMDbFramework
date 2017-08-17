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
    public var language: TMDbLanguage
    
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
        self.imageQuality = .medium
        self.apiKey = ""
        self.language = .english
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
        
        if (self.configurations == nil) {
            self.loadConfiguration() { _ in
                TMDbImageManager.imageFor(type: type, path: path, completition)
            }
        } else {
            TMDbImageManager.imageFor(type: type, path: path, completition)
        }
    }
    
    public func movieDetailFor(_ movie:TMDbMovie, _ completition: @escaping MovieDetailBlock) {
        
        TMDbMovieManager.detailMovie(movie, completition)
    }
    
    public func creditsFor(_ movie:TMDbMovie, _ completition: @escaping MovieDetailBlock) {
        
        TMDbMovieManager.creditsForMovie(movie, completition)
    }
}


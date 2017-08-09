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
    public var tmdbConfigurations: TMDbConfiguration?
    
    private var genreManager:TMDbGenreManager?
    
    public static let sharedInstance: TMDb = {
        let instance = TMDb()
        
        return instance
    }()
    
    private init() {
        let urlConfig = URLSessionConfiguration.default
        urlConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        self.alamofireManager = Alamofire.SessionManager(configuration: urlConfig)
        self.imageQuality = .Medium
    }
    
    public func loadMovies(listType:TMDbListMovieType, page:Int? = nil, completition: @escaping MovieListBlock) {
        
        switch listType {
        case .UpComming:
            TMDbMovieManager.upCommingMovies(page: page, completition)
        case .TopRated:
            TMDbMovieManager.topRatedMovies(page: page, completition)
        case .Popular:
            TMDbMovieManager.popularMovies(page: page, completition)
        }
    }
    
    public func movieGenreFor(id:Int, completition:@escaping GenreBlock) {
        
        if (self.genreManager == nil) {
            self.genreManager = TMDbGenreManager()
        }
        
        self.genreManager?.movieGenreBy(id, completition)
    }
    
    public func loadConfiguration(_ completition:@escaping ConfigurationBlock) {
        if (self.tmdbConfigurations == nil) {
            TMDbConfigurationManager.loadConfiguration({ configs in
                self.tmdbConfigurations = configs
                completition(configs)
            })
        } else {
            completition(self.tmdbConfigurations)
        }
    }
}

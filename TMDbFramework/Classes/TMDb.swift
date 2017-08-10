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
        self.alamofireManager.retrier = RetrierHandler()
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
}

class RetrierHandler: RequestRetrier {
    
    public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion:@escaping RequestRetryCompletion) {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 429 {
            completion(true, 10.0) // retry after 10 seconds
        } else {
            completion(false, 0.0) // don't retry
        }
    }
}


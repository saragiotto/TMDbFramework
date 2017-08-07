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
    
    public func loadMovies(listType:ListMovieType, page:Int? = nil, completition: @escaping MovieListBlock) {
        
        switch listType {
        case .UpComming:
            TMDbMovieManager.upCommingMovies(page: page, completition)
        case .TopRated:
            TMDbMovieManager.topRatedMovies(page: page, completition)
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

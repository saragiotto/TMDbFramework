//
//  TMDbMovieManager.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 8/5/17.
//
//

import Foundation
import SwiftyJSON

class TMDbMovieManager {
    
    internal static func upCommingMovies(page:Int?) {
        let configEndpoint = "movie/upcoming?"
        
        self.loadMovieWith(endpoint:configEndpoint, pageRequest: page)
    }
    
    internal static func topRatedMovies(page:Int?) {
        let configEndpoint = "movie/top_rated?"
        
        self.loadMovieWith(endpoint:configEndpoint, pageRequest: page)
    }
    
    internal static func popularMovies(page:Int?) {
        let configEndpoint = "movie/popular?"
        
        self.loadMovieWith(endpoint:configEndpoint, pageRequest: page)
    }
    
    private static func loadMovieWith(endpoint:String, pageRequest:Int?) {
        
        var page = 0
        
        if (pageRequest != nil && pageRequest! > 0) {
            page = pageRequest!
        }
        
        let manager = TMDb.sharedInstance.alamofireManager
        
        let url = TMDb.sharedInstance.buildURLWith(endpoint:endpoint)
        
        manager.request(url).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let loadedMovies = TMDbMovie(data: JSON(value))
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
}

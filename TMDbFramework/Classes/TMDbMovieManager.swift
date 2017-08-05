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
    
    internal static func upCommingMovies() {
        let configEndpoint = "movie/upcoming?"
        
        self.loadMovieWith(endpoint:configEndpoint)
    }
    
    internal static func topRatedMovies() {
        let configEndpoint = "movie/top_rated?"
        
        self.loadMovieWith(endpoint:configEndpoint)
    }
    
    private static func loadMovieWith(endpoint:String) {
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

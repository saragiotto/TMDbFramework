//
//  TMDbGenreManager.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 8/5/17.
//
//

import Foundation
import Alamofire
import SwiftyJSON

class TMDbGenreManager {
    
    var genres: [TMDbGenre]?
    
    internal func movieGenreBy(id: Int, completition:@escaping GenreBlock){
        
        if (genres == nil) {
            self.loadMovieGenres(requestId:id, completition: completition)
        } else {
            if (genres![id] == nil) {
                completition(nil)
            } else {
                completition(genres![id].name)
            }
        }
    }
    
    private func loadMovieGenres(requestId:Int, completition:@escaping GenreBlock) {
        let configEndpoint = "genre/movie/list?"
        
        let manager = TMDb.sharedInstance.alamofireManager
        
        let url = TMDb.sharedInstance.buildURLWith(endpoint:configEndpoint)
        
        manager.request(url).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let jsonValue = JSON(value).dictionary
                    
                    if let results = jsonValue!["genres"] {
                        self.genres = []
                        
                        for genre in results {
                            self.genres!.append(TMDbGenre(data: JSON(genre)))
                        }
                        
                        
                        if (self.genres![requestId] == nil) {
                            completition(nil)
                        } else {
                            completition(self.genres![requestId].name)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
}

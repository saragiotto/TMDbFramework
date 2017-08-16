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
    
    func movieGenreBy(_ id: Int, _ completition:@escaping GenreBlock){
        
        if (genres == nil) {
            self.loadMovieGenres(requestId:id, completition: completition)
        } else {
            completition(self.getNameBy(id))
        }
    }
    
    private func getNameBy(_ id: Int) -> String? {
        for genre in self.genres! {
            if (genre.id == id) {
                return genre.name
            }
        }
        
        return nil
    }
    
    private func loadMovieGenres(requestId:Int, completition:@escaping GenreBlock) {
        let configEndpoint = "genre/movie/list?"
        
        let manager = TMDb.sharedInstance.alamofireManager
        
        let url = TMDbUtils.buildURLWith(endpoint:configEndpoint)
        
        TMDbRetrierHandler.sharedInstance.addRequest()
        
        manager.request(url).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let jsonValue = JSON(value).dictionary
                    
                    if let results = jsonValue!["genres"]!.array {
                        self.genres = []
                        
                        for genre in results {
                            self.genres!.append(TMDbGenre(data: genre))
                        }
                        
                        completition(self.getNameBy(requestId))
                    }
                }
            case .failure(let error):
                completition(nil)
                print(error)
            }
            
        }
    }
}

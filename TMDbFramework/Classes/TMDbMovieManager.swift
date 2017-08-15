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
    
    static func upCommingMovies(page:Int?, allowExplicit:Bool = false, _ completition: @escaping MovieListBlock) {
        let configEndpoint = "movie/upcoming?"
        
        self.loadMovieWith(endpoint:configEndpoint, pageRequest: page, allowExplicit:allowExplicit, completition)
    }
    
    static func topRatedMovies(page:Int?, allowExplicit:Bool = false, _ completition: @escaping MovieListBlock) {
        let configEndpoint = "movie/top_rated?"
        
        self.loadMovieWith(endpoint:configEndpoint, pageRequest: page, allowExplicit:allowExplicit, completition)
    }
    
    static func popularMovies(page:Int?, allowExplicit:Bool = false, _ completition: @escaping MovieListBlock) {
        let configEndpoint = "movie/popular?"
        
        self.loadMovieWith(endpoint:configEndpoint, pageRequest: page, allowExplicit:allowExplicit, completition)
    }
    
    private static func loadMovieWith(endpoint:String, pageRequest:Int?, allowExplicit:Bool = false, _ completition: @escaping MovieListBlock) {
        
        var page = 1
        
        if (pageRequest != nil && pageRequest! > 0) {
            page = pageRequest!
        }
        
        let manager = TMDb.sharedInstance.alamofireManager
        
        let url = TMDbUtils.buildURLWith(endpoint:endpoint, page:page)
        
        manager.request(url).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let jsonValue = JSON(value).dictionary
                    
                    let result = TMDbListResult(page: (jsonValue!["page"]?.int)!, totalPages: (jsonValue!["total_pages"]?.int)!, totalResults: (jsonValue!["total_results"]?.int)!)
                    
                    var movies:[TMDbMovie] = []
                    
                    if let results = jsonValue!["results"]!.array {
                        
                        for jsonMovie in results {
                            let movie = TMDbMovie(data: jsonMovie)
                            
                            if (!allowExplicit) {
                                if (movie.adult != true) {
                                    movies.append(movie)
                                }
                            } else {
                                movies.append(movie)
                            }
                            
                        }
                        
                    }
                    
                    completition(result, movies)
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    static func detailMovie(_ movie:TMDbMovie, _ completition: @escaping MovieDetailBlock) {
        
        let detailEndpoint = "movie/" + String.init(describing: movie.id!) + "?"
        
        let manager = TMDb.sharedInstance.alamofireManager
        
        let url = TMDbUtils.buildURLWith(endpoint:detailEndpoint)
        
        manager.request(url).validate().responseJSON { response in
        
            switch response.result {
            case .success:
                
                if let value = response.result.value {
                    let jsonValue = JSON(value)
                    
                    movie.populateDetail(data: jsonValue)
                    
                    completition(movie)

                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

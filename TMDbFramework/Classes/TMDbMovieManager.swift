//
//  TMDbMovieManager.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 8/5/17.
//
//

import Foundation
import SwiftyJSON

extension TMDb {
    
    public func listMoviesOf(type:TMDbListMovieType, page pageRequest:Int? = nil, allowExplicit:Bool = false, _ completition: @escaping MovieListBlock) {
        
        let endpoint = "movie/" + type.rawValue
        let manager = TMDb.sharedInstance.alamofireManager
        var page = 1
        
        if (pageRequest != nil && pageRequest! > 0) {
            page = pageRequest!
        }
        
        let url = TMDbUtils.buildURLWith(endpoint:endpoint, page:page)
        
        TMDbRetrierHandler.sharedInstance.addRequest()
        
        manager.request(url).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let jsonValue = JSON(value).dictionary
                    
                    let result = TMDbListResult(page: (jsonValue!["page"]?.int)!, totalPages: (jsonValue!["total_pages"]?.int)!, totalResults: (jsonValue!["total_results"]?.int)!)
                    
                    var movies:[TMDbMovie]? = nil
                    
                    if let results = jsonValue!["results"]!.array {
                        
                        movies = self.filterMovies(results, allowExplicit);
                        
                    }
                    
                    completition(result, movies)
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    private func filterMovies(_ data:[JSON], _ allowExplicit:Bool) -> [TMDbMovie]? {
        
        var list:[TMDbMovie] = []
            
        for jsonMovie in data {
            let movie = TMDbMovie(data: jsonMovie)
            
            if (!allowExplicit) {
                if (movie.adult != true) {
                    list.append(movie)
                }
            } else {
                list.append(movie)
            }
        }
    
        
        return list.count > 0 ? list : nil
    }
    
    public func movieDetailFor(id movieId:String, _ completition: @escaping MovieDetailBlock) {
        
        let detailEndpoint = "movie/" + movieId + "?"
        let manager = TMDb.sharedInstance.alamofireManager
        let url = TMDbUtils.buildURLWith(endpoint:detailEndpoint)
        
        TMDbRetrierHandler.sharedInstance.addRequest()
        
        manager.request(url).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                
                if let value = response.result.value {
                    let jsonValue = JSON(value)
                    
                    let movie = TMDbMovie(data: jsonValue)
                    
                    movie.populateDetail(data: jsonValue)
                    
                    completition(movie)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func movieDetailFor(_ movie:TMDbMovie, _ completition: @escaping MovieDetailBlock) {
        
        let detailEndpoint = "movie/" + String.init(describing: movie.id!) + "?"
        let manager = TMDb.sharedInstance.alamofireManager
        let url = TMDbUtils.buildURLWith(endpoint:detailEndpoint)
        
        TMDbRetrierHandler.sharedInstance.addRequest()
        
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
    
    public func creditsFor(_ movie:TMDbMovie, _ completition: @escaping MovieDetailBlock) {
        
        let creditsEndpoint = "movie/" + String.init(describing: movie.id!) + "/credits?"
        let manager = TMDb.sharedInstance.alamofireManager
        let url = TMDbUtils.buildURLWith(endpoint:creditsEndpoint)
        
        TMDbRetrierHandler.sharedInstance.addRequest()
        
        manager.request(url).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                
                if let value = response.result.value {
                    let jsonValue = JSON(value)
                    
                    movie.populateCredits(data: jsonValue)
                    
                    completition(movie)
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

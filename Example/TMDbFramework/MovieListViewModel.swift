//
//  MovieListViewModel.swift
//  TMDbFramework
//
//  Created by Leonardo Saragiotto on 8/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import TMDbFramework

typealias MovieListCompletition = (TMDbListResult, [TMDbMovie]?) -> Void

class MovieListViewModel {
    
    let tmdbModel: TMDb!
    
    var movies: [TMDbMovie]?
    
    var page: Int?
    
    var totalPages: Int?
    
    var totalResults: Int?
    
    
    init() {
        tmdbModel = TMDb.sharedInstance
        tmdbModel.imageQuality = .medium
        page = 0
        movies = nil
        totalPages = nil
        totalResults = nil
    }
    
    func loadMovies(_ completition: @escaping () -> ()) {
        
        page! += 1
        
        tmdbModel.listMoviesOf(type: .upComming, page: page) { response, movieList in
            
            if (self.movies == nil) {
                self.movies = movieList
            } else {
                self.movies! += movieList!
            }
        
            self.page = response.page
            
            self.totalPages = response.totalPages
            
            self.totalResults = response.totalResults
            
            completition()
            
        }
    }
    
}

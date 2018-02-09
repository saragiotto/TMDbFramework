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
    
    public let tmdbModel: TMDb!
    
    var movies: [TMDbMovie]?
    
    var page: Int?
    
    var totalPages: Int?
    
    var totalResults: Int?
    
    var requestResults: Int?
    
    init() {
        tmdbModel = TMDb.shared
        tmdbModel.imageQuality = .medium
        page = 0
        movies = nil
        totalPages = nil
        totalResults = nil
        requestResults = nil
    }
    
    func loadMovies(_ completition: @escaping () -> ()) {
        
        page! += 1
        
        if (totalPages != nil &&  page! > totalPages!) {
            return
        }
        
        tmdbModel.listMoviesOf(type: .upComing, page: page) { response, movieList in
            
            if (self.movies == nil) {
                self.movies = movieList
            } else {
                self.movies! += movieList!
            }
        
            self.page = response.page
            
            self.totalPages = response.totalPages
            
            self.totalResults = response.totalResults
            
            self.requestResults = movieList?.count
            
            completition()
            
        }
    }
    
}

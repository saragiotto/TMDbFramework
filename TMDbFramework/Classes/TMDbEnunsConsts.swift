//
//  TMDbEnunsConsts.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 8/4/17.
//
//

import Foundation

public enum ListMovieType {
    case UpComming
    case TopRated
    case Popular
}

class TMDbEnunsConsts {

    static let apiKeyV3 = "094bda1680d9981474a3647d78d554bd"
    
    static let defaultBearer = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOTRiZGExNjgwZDk5ODE0NzRhMzY0N2Q3OGQ1NTRiZCIsInN1YiI6IjU4ODlmNDk0YzNhMzY4NTllOTAxZmQyYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sa_6LR_LvCgAcl3Z1Z--jhdy1USpy4F6JP257vCs1E8"
    
    static let baseTMDbURLV3 = "https://api.themoviedb.org/3/"
    
    static let moviesUpcomming = "movie/upcoming?"

}

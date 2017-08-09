//
//  TMDbEnunsConsts.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 8/4/17.
//
//

import Foundation

public typealias GenreBlock = (String?) -> Void

public typealias MovieListBlock = (TMDbListResult, [TMDbMovie]?) -> Void

public typealias MovieBlock = (TMDbMovie?) -> Void

public typealias ConfigurationBlock = (TMDbConfiguration?) -> Void

public enum TMDbListMovieType {
    case UpComming
    case TopRated
    case Popular
}

public enum TMDbImageQuality {
    case Low
    case Medium
    case High
    case VeryHigh
}

internal let kApiKeyV3 = "094bda1680d9981474a3647d78d554bd"

internal let kBaseTMDbURLV3 = "https://api.themoviedb.org/3/"

class TMDbEnunsConsts {

}

public class TMDbListResult {
    public let page:Int
    public let totalPages:Int
    public let totalResults:Int
    
    init(page:Int, totalPages:Int, totalResults:Int) {
        self.page = page
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

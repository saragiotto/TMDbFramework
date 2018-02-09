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

public typealias MovieDetailBlock = (TMDbMovie?) -> Void

public typealias PeopleListBlock = (TMDbListResult, [TMDbPeople]?) -> Void

public typealias PeopleDetailBlock = (TMDbPeople?) -> Void

public typealias ImageBlock = (TMDbImage?) -> Void

public typealias ImagesBlock = ([TMDbImage]?) -> Void

public typealias ConfigurationBlock = (TMDbConfiguration?) -> Void

public enum TMDbListMovieType: String {
    case upComing = "upcoming"
    case topRated = "top_rated"
    case popular = "popular"
}

public enum TMDbImageQuality {
    case low
    case medium
    case high
    case veryHigh
}

public enum TMDbImageType {
    case backdrop
    case logo
    case poster
    case profile
    case still
}

public enum TMDbLanguage: String {
    case english = "en"
    case spanish = "es"
    case french = "fr"
    case portuguese = "pt"
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

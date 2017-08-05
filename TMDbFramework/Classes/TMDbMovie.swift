//
//  TMDbMovie.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 8/5/17.
//
//

import Foundation
import SwiftyJSON

class TMDbMovie {
    
    let posterPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?
    let genres_ids: [Int]?
    let id: Int?
    let originalTitle: String?
    let originalLanguage: String?
    let title: String?
    let backdropPath: String?
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let voteAverage: Double?
    
    init(data:JSON) {
        print("\(data)")
        
        posterPath = ""
        adult = false
        overview = ""
        releaseDate = ""
        genres_ids = [0]
        id = 0
        originalTitle = ""
        originalLanguage = ""
        title = ""
        backdropPath = ""
        popularity = 0.0
        voteCount = 0
        video = false
        voteAverage = 0.0
    }

}

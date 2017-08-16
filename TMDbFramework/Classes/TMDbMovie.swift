//
//  TMDbMovie.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 8/5/17.
//
//

import Foundation
import SwiftyJSON

public class TMDbMovie {
    
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
    
    var budget: Int?
    var homepage: String?
    var imdbId: String?
    var productionCompanies: [String]?
    var productionCountries: [String]?
    var revenue: Int?
    var runtime: Int?
    var spokenLanguages: [String]?
    var status: String?
    var tagline: String?
    
    public var cast:[TMDbCast]?
    
    init(data:JSON) {
        
        posterPath = data["poster_path"].string
        adult = data["adult"].bool
        overview = data["overview"].string
        releaseDate = data["release_date"].string
        genres_ids = data["genre_ids"].arrayValue.map({$0.intValue})
        id = data["id"].int
        originalTitle = data["original_title"].string
        originalLanguage = data["original_language"].string
        title = data["title"].string
        backdropPath = data["backdrop_path"].string
        popularity = data["popularity"].double
        voteCount = data["vote_count"].int
        video = data["video"].bool
        voteAverage = data["vote_average"].double
    }

    func populateDetail(data: JSON) {
        
        budget = data["budget"].int
        homepage = data["homepage"].string
        imdbId = data["imdb_id"].string
        productionCompanies = data["production_companies"].arrayValue.map({$0["name"].stringValue})
        productionCountries = data["production_countries"].arrayValue.map({$0["name"].stringValue})
        revenue = data["revenue"].int
        runtime = data["runtime"].int
        spokenLanguages = data["spoken_languages"].arrayValue.map({$0["name"].stringValue})
        status = data["status"].string
        tagline = data["tagline"].string
    }
    
    func populateCredits(data: JSON) {
        
        cast = data["cast"].arrayValue.map({TMDbCast.init(data: $0)})
        
    }
    
    
    
    
    
    
    
    
    
    
    
}

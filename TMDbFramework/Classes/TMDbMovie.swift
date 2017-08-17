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
    
    public let posterPath: String?
    public let adult: Bool?
    public let overview: String?
    public let releaseDate: String?
    public let genresIds: [Int]?
    public let id: Int?
    public let originalTitle: String?
    public let originalLanguage: String?
    public let title: String?
    public let backdropPath: String?
    public let popularity: Double?
    public let voteCount: Int?
    public let video: Bool?
    public let voteAverage: Double?
    
    public var budget: Int?
    public var homepage: String?
    public var imdbId: String?
    public var productionCompanies: [String]?
    public var productionCountries: [String]?
    public var revenue: Int?
    public var runtime: Int?
    public var spokenLanguages: [String]?
    public var status: String?
    public var tagline: String?
    
    public var cast:[TMDbCast]?
    
    init(data:JSON) {
        
        posterPath = data["poster_path"].string
        adult = data["adult"].bool
        overview = data["overview"].string
        releaseDate = data["release_date"].string
        genresIds = data["genre_ids"].arrayValue.map({$0.intValue})
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

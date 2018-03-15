//
//  TMDbPeople.swift
//  Alamofire
//
//  Created by Leonardo Saragiotto on 2/1/18.
//

import Foundation
import SwiftyJSON

open class TMDbPeople {
    public let adult:Bool?
    public let id:Int?
    public let name:String?
    public let popularity:Double?
    public let profilePath:String?
    public let knownFor:[TMDbMovie?]
    
    public var biography:String?
    public var birthday:String?
    public var deathday:String?
    public var gender:Int?
    public var homepage:String?
    public var imdbId:String?
    public var placeOfBirth:String?
    
    init(data:JSON) {
        adult = data["adult"].bool
        id = data["id"].int
        name = data["name"].string
        popularity = data["popularity"].double
        profilePath = data["profile_path"].string
        
        knownFor = data["known_for"].arrayValue.map({ jsonValue in
            let movieOrTvSeries = JSON(jsonValue).dictionary
            if let mediaType = movieOrTvSeries!["media_type"]?.string {
                if mediaType.isEqual("movie") {
                    return TMDbMovie(data:jsonValue)
                }
            }
            return nil
        })
    }
    
    func populateDetail(data: JSON) {
        biography = data["biography"].string
        birthday = data["birthday"].string
        deathday = data["deathday"].string
        gender = data["gender"].int
        homepage = data["homepage"].string
        imdbId = data["imdb_id"].string
        placeOfBirth = data["place_of_birth"].string
    }
}

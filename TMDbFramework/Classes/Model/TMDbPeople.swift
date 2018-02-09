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
    public let biography:String?
    public let deathday:String?
    public let gender:Int?
    public let homepage:String?
    public let id:Int?
    public let imdbId:String?
    public let name:String?
    public let placeOfBirth:String?
    public let popularity:Int?
    public let profilePath:String?
    
    init(data:JSON) {
        adult = data["adult"].bool
        id = data["id"].int
        name = data["name"].string
        profilePath = data["profile_path"].string
        popularity = data["popularity"].double
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

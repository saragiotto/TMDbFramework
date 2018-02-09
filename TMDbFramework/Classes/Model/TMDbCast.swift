//
//  TMDbCast.swift
//  Pods
//
//  Created by Leonardo Augusto N Saragiotto on 15/08/17.
//
//

import Foundation
import SwiftyJSON

open class TMDbCast {
    
    public let castId: Int?
    public let character: String?
    public let creditId: String?
    public let gender: Int?
    public let id: Int?
    public let name: String?
    public let order: Int?
    public let profilePath: String?
    
    init(data: JSON) {
        
        castId = data["cast_id"].int
        character = data["character"].string
        creditId = data["credit_id"].string
        gender = data["gender"].int
        id = data["id"].int
        name = data["name"].string
        order = data["order"].int
        profilePath = data["profile_path"].string
    }
    
}

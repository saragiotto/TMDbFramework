//
//  TMDbCast.swift
//  Pods
//
//  Created by Leonardo Augusto N Saragiotto on 15/08/17.
//
//

import Foundation
import SwiftyJSON

open class TMDbCast{
    
    let castId: Int?
    let character: String?
    let creditId: String?
    let gender: Int?
    let id: Int?
    let name: String?
    let order: Int?
    let profilePath: String?
    
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

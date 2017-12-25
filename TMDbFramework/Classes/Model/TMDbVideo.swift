//
//  TMDbVideo.swift
//  TMDbFramework
//
//  Created by Leonardo Saragiotto on 12/25/17.
//

import Foundation
import SwiftyJSON

public class TMDbVideo {
    public let id:String?
    public let iso6391:String?
    public let iso31661:String?
    public let key:String?
    public let name:String?
    public let site:String?
    public let size:String?
    public let type:String?
    
    init(data:JSON) {
        id = data["id"].string
        iso6391 = data["iso_639_1"].string
        iso31661 = data["iso_3166_1"].string
        key = data["key"].string
        name = data["name"].string
        site = data["size"].string
        size = data["site"].string
        type = data["type"].string
    }
}

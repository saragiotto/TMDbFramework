//
//  TMDbConfiguration.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 8/4/17.
//
//

import Foundation
import SwiftyJSON

class TMDbConfiguration {
    
    let imageBaseUrl: String?
    
    let secureImageBaseUrl: String?
    
    let backdropSizes: [String]?
    
    let logoSizes: [String]?
    
    let posterSizes: [String]?
    
    let profileSizes: [String]?
    
    let stillSizes: [String]?
    
    let backdropSize: String?
    
    let logoSize: String?
    
    let posterSize: String?
    
    let profileSize: String?
    
    let stillSize: String?
    
    init(data:JSON) {
        
        let imageQuality = TMDb.sharedInstance.imageQuality
        
        self.imageBaseUrl = data["base_url"].string
        
        self.secureImageBaseUrl = data["secure_base_url"].string
        
        self.backdropSizes = data["backdrop_sizes"].arrayValue.map({$0.stringValue})
        
        self.backdropSize = TMDbConfiguration.setSizeFor(list: self.backdropSizes, quality: imageQuality)
        
        self.logoSizes = data["logo_sizes"].arrayValue.map({$0.stringValue})
        
        self.logoSize = TMDbConfiguration.setSizeFor(list: self.logoSizes, quality: imageQuality)
        
        self.posterSizes = data["poster_sizes"].arrayValue.map({$0.stringValue})
        
        self.posterSize = TMDbConfiguration.setSizeFor(list: self.posterSizes, quality: imageQuality)
        
        self.profileSizes = data["profile_sizes"].arrayValue.map({$0.stringValue})
        
        self.profileSize = TMDbConfiguration.setSizeFor(list: self.profileSizes, quality: imageQuality)
        
        self.stillSizes = data["still_sizes"].arrayValue.map({$0.stringValue})
        
        self.stillSize = TMDbConfiguration.setSizeFor(list: self.stillSizes, quality: imageQuality)
    }
    
    static func setSizeFor(list:[String]?, quality:TMDbImageQuality) -> String? {
        
        if (list == nil) {
            return nil
        }
        
        var newList = list
        
        newList?.removeLast()
        
        return nil
    }
}

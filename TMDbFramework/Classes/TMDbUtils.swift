//
//  TMDbUtils.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 8/6/17.
//
//

import Foundation

class TMDbUtils {
    
    internal static func buildURLWith(endpoint:String, page:Int? = nil) -> String {
        
        let mdbFrmk = TMDb.sharedInstance
        
        let apiKey = "api_key=" + ((mdbFrmk.apiKey.isEmpty) ? kApiKeyV3 : mdbFrmk.apiKey)
        
        let language = "&language=" + mdbFrmk.language.rawValue
        
        var finalString = kBaseTMDbURLV3 + endpoint + apiKey + language
        
        if (page != nil) {
            finalString += "&page=\(String(describing: page!))"
        }

        return finalString
    }
    
    internal static func buildImageURL(path:String, type:TMDbImageType) -> String {
        
        let configuration = TMDb.sharedInstance.configurations!
        
        var size = ""
        
        switch type {
        case .backdrop:
            size = configuration.backdropSize!
        case .logo:
            size = configuration.logoSize!
        case .poster:
            size = configuration.posterSize!
        case .profile:
            size = configuration.profileSize!
        case .still:
            size = configuration.stillSize!
        }
        
        return configuration.secureImageBaseUrl! + size + path
    }
}

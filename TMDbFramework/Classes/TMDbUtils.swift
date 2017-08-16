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
        
        let apiKey = (TMDb.sharedInstance.apiKey != "") ? TMDb.sharedInstance.apiKey : kApiKeyV3
        
        var finalString = kBaseTMDbURLV3 + endpoint + "api_key=" + apiKey + "&language=en-US"
        
        if (page != nil) {
            finalString += "&page=\(String(describing: page!))"
        }

        return finalString
    }
    
    internal static func buildImageURL(path:String, type:TMDbImageType) -> String {
        
        let configuration = TMDb.sharedInstance.configurations!
        
        var size = ""
        
        switch type {
        case .Backdrop:
            size = configuration.backdropSize!
        case .Logo:
            size = configuration.logoSize!
        case .Poster:
            size = configuration.posterSize!
        case .Profile:
            size = configuration.profileSize!
        case .Still:
            size = configuration.stillSize!
        }
        
        return configuration.secureImageBaseUrl! + size + path
    }
}

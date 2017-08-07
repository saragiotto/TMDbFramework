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
        
        var finalString = kBaseTMDbURLV3 + endpoint + "api_key=" + kApiKeyV3 + "&language=en-US"
        
        if (page != nil) {
            finalString += "&page=\(String(describing: page!))"
        }

        return finalString
    }
}

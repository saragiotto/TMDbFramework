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
    
    let imageBaseUrl: String
    
    let secureImageBaseUrl: String
    
    let backdropSizes: [String]
    
    let posterSizes: [String]
    
    let profileSizes: [String]
    
    let stillSizes: [String]
    
    init(data:JSON) {
        
        print(data)
        
        self.imageBaseUrl = ""
        self.secureImageBaseUrl = ""
        self.backdropSizes = [""]
        self.posterSizes = [""]
        self.profileSizes = [""]
        self.stillSizes = [""]
        
    }
    
}

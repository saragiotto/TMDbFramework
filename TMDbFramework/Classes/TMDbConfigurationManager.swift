//
//  TMDbConfigurationManager.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 8/4/17.
//
//

import Foundation
import Alamofire
import SwiftyJSON

class TMDbConfigurationManager {
    
    internal static func loadConfiguration() {
        
        let configEndpoint = "configuration?"
        
        let manager = TMDb.sharedInstance.alamofireManager
        
        let url = TMDbUtils.buildURLWith(endpoint:configEndpoint)
        
        manager.request(url).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let loadedConfigs = TMDbConfiguration(data: JSON(value))
                }
            case .failure(let error):
                print(error)
            }
         
        }
        
    }
    
}

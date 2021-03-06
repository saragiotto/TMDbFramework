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

extension TMDb {
    
    public func loadConfiguration(_ completition:@escaping ConfigurationBlock) {
        
        if let config = self.configurations {
            completition(config)
            return
        }
        
        let configEndpoint = "configuration"
        let manager = TMDb.shared.alamofireManager
        let url = TMDbUtils.buildURLWith(endpoint:configEndpoint)
        
        TMDbRetrierHandler.shared.addRequest()
        
        manager.request(url).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let results = JSON(value).dictionary
                    
                    if let results = results!["images"] {
                        self.configurations = TMDbConfiguration(data: results)
                        completition(self.configurations)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

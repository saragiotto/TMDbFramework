//
//  TMDbImageManager.swift
//  Pods
//
//  Created by Leonardo Augusto N Saragiotto on 10/08/17.
//
//

import Foundation
import Alamofire
import SwiftyJSON

class TMDbImageManager {

    static func imageFor(type:TMDbImageType, path:String, _ completition: @escaping ImageBlock) {
        
        let url = TMDbUtils.buildImageURL(path: path, type: type)
    
        DispatchQueue.global(qos: .userInitiated).async {
            if let imgData = try? Data(contentsOf: url.asURL()) {
                if let image = UIImage.init(data: imgData) {
                
                    completition(TMDbImage.init(image: image, type: type))
                } else {
                    
                    completition(nil)
                }
            } else {
                
                completition(nil)
            }
        }

    }
}
    

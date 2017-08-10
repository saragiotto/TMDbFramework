//
//  TMDbImageManager.swift
//  Pods
//
//  Created by Leonardo Augusto N Saragiotto on 10/08/17.
//
//

import Foundation
import Alamofire
import AlamofireImage

class TMDbImageManager {

    static func imageFor(type:TMDbImageType, path:String, _ completition: @escaping ImageBlock) {
        
        let url = TMDbUtils.buildImageURL(path: path, type: type)
        
        Alamofire.request(url).responseImage(imageScale: 1.0) { response in
            debugPrint(response)
            debugPrint(response.result)
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                completition(TMDbImage.init(image: image, type: type))
            } else {
                completition(nil)
            }
        }

    }
}
    

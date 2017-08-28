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

extension TMDb {
    
    public func loadImageFor(path:String, type:TMDbImageType, _ completition:@escaping ImageBlock) {
        
        if (self.configurations == nil) {
            self.loadConfiguration() { _ in
                self.imageFor(type: type, path: path, completition)
            }
        } else {
            self.imageFor(type: type, path: path, completition)
        }
    }
    
    public func imageURLFor(path:String, type:TMDbImageType, _ completition:@escaping (String)->()) {
        if (self.configurations == nil) {
            self.loadConfiguration() { _ in
                completition(TMDbUtils.buildImageURL(path: path, type: type))
            }
        } else {
            completition(TMDbUtils.buildImageURL(path: path, type: type))
        }
        
    }

    func imageFor(type:TMDbImageType, path:String, _ completition: @escaping ImageBlock) {
        
        let url = TMDbUtils.buildImageURL(path: path, type: type)
        
        Alamofire.request(url).responseImage(imageScale: 1.0) { response in
            debugPrint(response)
            debugPrint(response.result)
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                completition(TMDbImage.init(image: image, type: type, path: path))
            } else {
                completition(nil)
            }
        }

    }
}
    

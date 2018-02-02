//
//  TMDbImageManager.swift
//  Pods
//
//  Created by Leonardo Augusto N Saragiotto on 10/08/17.
//
//

import Foundation
import SwiftyJSON
import Alamofire

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

        Alamofire.request(url).responseData() { response in
            debugPrint(response)
            debugPrint(response.result)
            
            if let image = UIImage.init(data: response.result.value!) {
                print("image downloaded: \(image)")
                completition(TMDbImage.init(size: image.size, type: type, path: path))
            } else {
                completition(nil)
            }
        }
    }
    
    public func imagesFor(movieId:Int, _ completition: @escaping ImagesBlock) {
        let endpoint = "movie/" + String(movieId) + "/images?"
        let manager = TMDb.shared.alamofireManager
        
        let url = TMDbUtils.buildURLWith(endpoint:endpoint)
        
        TMDbRetrierHandler.shared.addRequest()
        
        manager.request(url).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let jsonValue = JSON(value).dictionary
                    
                    var images:[TMDbImage]? = [TMDbImage]()
                    
                    if let backdropArray = jsonValue!["backdrops"]?.array {
                        
                        for backdropImagePath in backdropArray {
                            let backImage = TMDbImage(type: .backdrop, path: backdropImagePath["file_path"].string!)
                            images?.append(backImage)
                        }
                        
                    }
                    
                    if let posterArray = jsonValue!["posters"]?.array {
                        
                        for posterImagePath in posterArray {
                            let backImage = TMDbImage(type: .poster, path: posterImagePath["file_path"].string!)
                            images?.append(backImage)
                        }
                    }
                    
                    if (images?.count == 0) { completition(nil) }
                    
                    completition(images)
                    
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    public func videosFor(movieId:Int, _ completion: @escaping ([TMDbVideo]) -> ()) {
        let endpoint = "movie/" + String(movieId) + "/videos?"
        let manager = TMDb.shared.alamofireManager
        let url = TMDbUtils.buildURLWith(endpoint:endpoint)
        
        TMDbRetrierHandler.shared.addRequest()
        
        manager.request(url).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let jsonValue = JSON(value).dictionary
                    
                    var videoList:[TMDbVideo] = [TMDbVideo]()
                    
                    if let videoResponse = jsonValue!["results"]?.array {
                        
                        for videoResp in videoResponse {
                            let video = TMDbVideo(data:videoResp)
                            videoList.append(video)
                        }
                    }
                    
                    completion(videoList)
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
    

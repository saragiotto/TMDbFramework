//
//  TMDbImage.swift
//  Pods
//
//  Created by Leonardo Augusto N Saragiotto on 10/08/17.
//
//

import Foundation
import Alamofire
import SwiftyJSON

public class TMDbImage {

    let image:UIImage?
    
    let size:CGSize?
    
    let type:TMDbImageType?
    
    init(image:UIImage, type:TMDbImageType) {
        
        self.image = image
        
        self.size = image.size
        
        self.type = type
    }
    
}
    

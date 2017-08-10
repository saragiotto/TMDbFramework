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

    public let image:UIImage?
    
    public let size:CGSize?
    
    public let type:TMDbImageType?
    
    init(image:UIImage, type:TMDbImageType) {
        
        self.image = image
        
        self.size = image.size
        
        self.type = type
    }
    
}
    

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
    
    public let size:CGSize?
    public let type:TMDbImageType?
    public let path:String?
    
    init(size:CGSize, type:TMDbImageType, path:String) {
        self.size = size
        self.type = type
        self.path = path
    }
    
    init(type:TMDbImageType, path:String) {
        self.size = nil
        self.type = type
        self.path = path
    }
    
}
    

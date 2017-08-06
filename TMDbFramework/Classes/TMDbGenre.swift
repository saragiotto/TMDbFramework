//
//  TMDbGenre.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 8/5/17.
//
//

import Foundation
import SwiftyJSON

class TMDbGenre {
    
    let id: Int
    let name: String
    
    init(data: JSON) {
        print("\(data)")
        
        self.id = 0
        self.name = ""
    }
}

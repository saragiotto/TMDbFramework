//
//  TMDbConfiguration.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 8/4/17.
//
//

import Foundation
import SwiftyJSON

public class TMDbConfiguration {
    
    let imageBaseUrl: String?
    
    let secureImageBaseUrl: String?
    
    let backdropSizes: [String]?
    
    let logoSizes: [String]?
    
    let posterSizes: [String]?
    
    let profileSizes: [String]?
    
    let stillSizes: [String]?
    
    public let backdropSize: String?
    
    public let logoSize: String?
    
    public let posterSize: String?
    
    public let profileSize: String?
    
    public let stillSize: String?
    
    init(data:JSON) {
        
        let imageQuality = TMDb.shared.imageQuality
        
        self.imageBaseUrl = data["base_url"].string
        
        self.secureImageBaseUrl = data["secure_base_url"].string
        
        self.backdropSizes = data["backdrop_sizes"].arrayValue.map({$0.stringValue})
        
        self.backdropSize = TMDbConfiguration.getSizeFor(list: self.backdropSizes, quality: imageQuality)
        
        self.logoSizes = data["logo_sizes"].arrayValue.map({$0.stringValue})
        
        self.logoSize = TMDbConfiguration.getSizeFor(list: self.logoSizes, quality: imageQuality)
        
        self.posterSizes = data["poster_sizes"].arrayValue.map({$0.stringValue})
        
        self.posterSize = TMDbConfiguration.getSizeFor(list: self.posterSizes, quality: imageQuality)
        
        self.profileSizes = data["profile_sizes"].arrayValue.map({$0.stringValue})
        
        self.profileSize = TMDbConfiguration.getSizeFor(list: self.profileSizes, quality: imageQuality)
        
        self.stillSizes = data["still_sizes"].arrayValue.map({$0.stringValue})
        
        self.stillSize = TMDbConfiguration.getSizeFor(list: self.stillSizes, quality: imageQuality)
    }
    
    static func getSizeFor(list:[String]?, quality:TMDbImageQuality) -> String? {
        
        if (list == nil) {
            return nil
        }
        
        var newList = list!
        let originalSize = newList.removeLast()
        
        if (newList.count == 1) {
            return newList.first
        }
        
        switch quality {
        case .low:
            return newList.first
        case .medium:
            return findMediumSizeFor(sizeList: newList, smallSize: newList.first!, bigSize: newList.last!)
        case .high:
            return newList.last
        case .veryHigh:
            return originalSize
        }
        
    }
    
    static private func findMediumSizeFor(sizeList:[String], smallSize:String, bigSize:String) -> String? {
        
        let smallSizeInt = convertTMDbSize(size: smallSize)!
        let bigSizeInt = convertTMDbSize(size: bigSize)!
        let midSizeInt = ((bigSizeInt - smallSizeInt) / 2) + smallSizeInt
        
        var floatDistance:Double?
        
        var mediuSize:String? = nil
        
        for (index, size) in sizeList.enumerated() {
            
            let sizeInt = convertTMDbSize(size: size)
            
            let distance:Double = Double(sizeInt! - midSizeInt) > 0.0 ? Double(sizeInt! - midSizeInt) : Double(midSizeInt - sizeInt!)
            
            if (floatDistance == nil || distance <= floatDistance!) {
                floatDistance = distance
                mediuSize = sizeList[index]
            }
        }
        
        return mediuSize
    }
    
    static private func convertTMDbSize(size:String) -> Int? {
        var givenSize = size
        givenSize.remove(at: givenSize.startIndex)
        
        return Int(givenSize)
    }

}

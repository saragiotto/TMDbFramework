//
//  TMDbPeopleManager.swift
//  Pods
//
//  Created by Leonardo Saragiotto on 2/8/18.
//

import Foundation
import SwiftyJSON

extension TMDb {

    public func listPopularPeople(page pageRequest:Int? = nil, allowExplicit:Bool = false, _ completition: @escaping PeopleListBlock) {
        
        let endpoint = "person/popular"
        let manager = TMDb.shared.alamofireManager
        var page = 1
        
        if (pageRequest != nil && pageRequest! > 0) {
            page = pageRequest!
        }
        
        let url = TMDbUtils.buildURLWith(endpoint:endpoint, page:page)
        
        TMDbRetrierHandler.shared.addRequest()
        
        manager.request(url).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let jsonValue = JSON(value).dictionary
                    
                    let result = TMDbListResult(page: (jsonValue!["page"]?.int)!, totalPages: (jsonValue!["total_pages"]?.int)!, totalResults: (jsonValue!["total_results"]?.int)!)
                    
                    var popularPeople:[TMDbPeople]? = nil
                    
                    if let results = jsonValue!["results"]!.array {
                        
                        popularPeople = self.filterPeople(results, allowExplicit);
                        
                    }
                    
                    completition(result, popularPeople)
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    private func filterPeople(_ data:[JSON], _ allowExplicit:Bool) -> [TMDbPeople]? {
        
        var list:[TMDbPeople] = []
        
        for jsonPeople in data {
            let people = TMDbPeople(data: jsonPeople)
            
            if (!allowExplicit) {
                if (people.adult != true) {
                    list.append(people)
                }
            } else {
                list.append(people)
            }
        }
        
        
        return list.count > 0 ? list : nil
    }
    
    public func peopleDetailFor(id peopleId:String, _ completition: @escaping PeopleDetailBlock) {
        
        let detailEndpoint = "person/" + peopleId
        let manager = TMDb.shared.alamofireManager
        let url = TMDbUtils.buildURLWith(endpoint:detailEndpoint)
        
        TMDbRetrierHandler.shared.addRequest()
        
        manager.request(url).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                
                if let value = response.result.value {
                    let jsonValue = JSON(value)
                    
                    let people = TMDbPeople(data: jsonValue)
                    
                    people.populateDetail(data: jsonValue)
                    
                    completition(people)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

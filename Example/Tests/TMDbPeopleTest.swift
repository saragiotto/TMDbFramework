//
//  TMDbPeopleTest.swift
//  TMDbFramework_Tests
//
//  Created by Leonardo Saragiotto on 2/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import TMDbFramework

class TMDbPeoplesTest: QuickSpec {
    override func spec() {
        describe("Test TMDbPeopleManager and TMDbPeople") {
            
            let tmdbPod:TMDb = TMDb.shared
            
            it("Request upComing Peoples ommiting page param") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listPopularPeople() { listResult, PeopleList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(PeopleList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 1 upComing Peoples") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listPopularPeople(page: 1) { listResult, PeopleList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(PeopleList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 3 upComing Peoples") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listPopularPeople(page: 3) { listResult, PeopleList in
                        
                        expect(listResult.page).to(equal(3))
                        expect(PeopleList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
        
            it("Detail People by id") {
                
                waitUntil(timeout: 8.0) { done in
                    tmdbPod.peopleDetailFor(id: "2231") { People in
                        
                        expect(People).notTo(beNil())
                        done()
                    }
                }
            }
        }
    }
}

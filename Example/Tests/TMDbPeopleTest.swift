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
            
            it("Request popular Peoples ommiting page param") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listPopularPeople() { listResult, peopleList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(peopleList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 1 popular Peoples") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listPopularPeople(page: 1) { listResult, peopleList in
                        
                        expect(listResult.page).to(equal(1))
                        expect(peopleList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request page 3 popular Peoples") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listPopularPeople(page: 3) { listResult, peopleList in
                        
                        expect(listResult.page).to(equal(3))
                        expect(peopleList?.count).to(equal(20))
                        done()
                    }
                }
                
            }
            
            it("Request popular Peoples and check KnownFor property") {
                
                waitUntil(timeout: 12.0) { done in
                    tmdbPod.listPopularPeople() { listResult, peopleList in
                        
                        expect(peopleList?.count).to(beGreaterThan(0))
                        
                        let knownForList = peopleList?.first?.knownFor
                        
                        expect(knownForList?.count).to(beGreaterThan(0))
                        expect(knownForList?.first??.id).toNot(beNil())
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

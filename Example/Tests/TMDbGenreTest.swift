//
//  TMDbGenreTest.swift
//  TMDbFramework
//
//  Created by Leonardo Augusto N Saragiotto on 07/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import TMDbFramework

class TMDbGenreTest: QuickSpec {
    override func spec() {

        describe("Test TMDbGenreManager and TMDbGenre") {
            let tmdbPod:TMDb! = TMDb.sharedInstance
            
            it("Request existing genreName") {
                
                waitUntil { done in
                    tmdbPod.movieGenreFor(id: 28) { genreName in
                        
                        expect(genreName).notTo(beNil())
                        done()
                    }
                }
            }
            
            it("Request not existing genreName") {
                
                waitUntil { done in
                    tmdbPod.movieGenreFor(id: 28000) { genreName in
                        
                        expect(genreName).to(beNil())
                        done()
                    }
                }
            }
        }
    }
}